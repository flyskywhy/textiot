package cmd

import (
	"errors"

	"github.com/textileio/go-textile/util"
)

var errMissingNoteId = errors.New("missing notification ID")

func init() {
	register(&notificationsCmd{})
}

type notificationsCmd struct {
	List lsNotificationsCmd   `command:"ls" description:"List notifications"`
	Read readNotificationsCmd `command:"read" description:"Mark notification(s) as read"`
}

func (x *notificationsCmd) Name() string {
	return "notifications"
}

func (x *notificationsCmd) Short() string {
	return "Manage notifications"
}

func (x *notificationsCmd) Long() string {
	return `
Notifications are generated by thread and account activity.
Use this command to list, get, and mark notifications as read.`
}

type lsNotificationsCmd struct {
	Client ClientOptions `group:"Client Options"`
}

func (x *lsNotificationsCmd) Usage() string {
	return `

Lists notifications.`
}

func (x *lsNotificationsCmd) Execute(args []string) error {
	setApi(x.Client)

	res, err := executeJsonCmd(GET, "notifications", params{}, nil)
	if err != nil {
		return err
	}
	output(res)
	return nil
}

type readNotificationsCmd struct {
	Client ClientOptions `group:"Client Options"`
}

func (x *readNotificationsCmd) Usage() string {
	return `

Marks a notifiction as read by ID.
"textile notifications read all" marks all as read.`
}

func (x *readNotificationsCmd) Execute(args []string) error {
	if len(args) == 0 {
		return errMissingNoteId
	}
	setApi(x.Client)

	res, err := executeStringCmd(POST, "notifications/"+util.TrimQuotes(args[0])+"/read", params{})
	if err != nil {
		return err
	}
	output(res)
	return nil
}
