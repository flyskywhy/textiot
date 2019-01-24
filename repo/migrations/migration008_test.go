package migrations

import (
	"database/sql"
	"io/ioutil"
	"os"
	"path"
	"testing"
)

func initAt007(db *sql.DB, pin string) error {
	var sqlStmt string
	if pin != "" {
		sqlStmt = "PRAGMA key = '" + pin + "';"
	}
	sqlStmt += `
    create table threads (id text primary key not null, key text not null, sk blob not null, name text not null, schema text not null, initiator text not null, type integer not null, state integer not null, head text not null);
    create unique index thread_key on threads (key);
    `
	_, err := db.Exec(sqlStmt)
	if err != nil {
		return err
	}
	_, err = db.Exec("insert into threads(id, key, sk, name, schema, initiator, type, state, head) values(?,?,?,?,?,?,?,?,?)", "id", "key", []byte("sk"), "name", "schema", "initiator", 0, 1, "head")
	if err != nil {
		return err
	}
	return nil
}

func Test008(t *testing.T) {
	var dbPath string
	os.Mkdir("./datastore", os.ModePerm)
	dbPath = path.Join("./", "datastore", "mainnet.db")
	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		t.Error(err)
		return
	}
	if err := initAt007(db, ""); err != nil {
		t.Error(err)
		return
	}

	// go up
	var m Minor008
	if err := m.Up("./", "", false); err != nil {
		t.Error(err)
		return
	}

	// test new field
	_, err = db.Exec("update threads set members=? where id=?", "you,me", "boom")
	if err != nil {
		t.Error(err)
		return
	}

	// ensure that version file was updated
	version, err := ioutil.ReadFile("./repover")
	if err != nil {
		t.Error(err)
		return
	}
	if string(version) != "9" {
		t.Error("failed to write new repo version")
		return
	}

	if err := m.Down("./", "", false); err != nil {
		t.Error(err)
		return
	}
	os.RemoveAll("./datastore")
	os.RemoveAll("./repover")
}
