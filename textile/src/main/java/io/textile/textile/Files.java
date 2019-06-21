package io.textile.textile;

import io.textile.pb.Model.Block;
import io.textile.pb.View.FilesList;
import mobile.DataCallback;
import mobile.Mobile_;
import mobile.ProtoCallback;

/**
 * Provides access to Textile files related APIs
 */
public class Files extends NodeDependent {

    Files(final Mobile_ node) {
        super(node);
    }

    /**
     * Add raw data to to a Textile thread
     * @param data Raw bytes
     * @param threadId The thread id the data will be added to
     * @param handler An object that will get called with the resulting block
     */
    public void addData(byte[] data, String threadId, String caption, final Handlers.BlockHandler handler) {
        node.addData(data, threadId, caption, new ProtoCallback() {
            @Override
            public void call(byte[] data, Exception e) {
                if (e != null) {
                    handler.onError(e);
                    return;
                }
                try {
                    handler.onComplete(Block.parseFrom(data));
                } catch (Exception exception) {
                    handler.onError(exception);
                }
            }
        });
    }

    /**
     * Add file(s) to to a Textile thread
     * @param files A comma-separated list of file paths
     * @param threadId The thread id the data will be added to
     * @param handler An object that will get called with the resulting block
     */
    public void addFiles(String files, String threadId, String caption, final Handlers.BlockHandler handler) {
        node.addFiles(files, threadId, caption, new ProtoCallback() {
            @Override
            public void call(byte[] data, Exception e) {
                if (e != null) {
                    handler.onError(e);
                    return;
                }
                try {
                    handler.onComplete(Block.parseFrom(data));
                } catch (Exception exception) {
                    handler.onError(exception);
                }
            }
        });
    }

    /**
     * Share files to a Textile thread
     * @param hash The hash of the files graph to share
     * @param threadId The thread id the data will be added to
     * @param handler An object that will get called with the resulting block
     */
    public void shareFiles(String hash, String threadId, String caption, final Handlers.BlockHandler handler) {
        node.shareFiles(hash, threadId, caption, new ProtoCallback() {
            @Override
            public void call(byte[] data, Exception e) {
                if (e != null) {
                    handler.onError(e);
                    return;
                }
                try {
                    handler.onComplete(Block.parseFrom(data));
                } catch (Exception exception) {
                    handler.onError(exception);
                }
            }
        });
    }

    /**
     * Get a list of files data from a thread
     * @param threadId The thread to query
     * @param offset The offset to beging querying from
     * @param limit The max number of results to return
     * @return An object containing a list of files data
     * @throws Exception The exception that occurred
     */
    public FilesList list(String threadId, String offset, long limit) throws Exception {
        byte[] bytes = node.files(threadId, offset, limit);
        return FilesList.parseFrom(bytes != null ? bytes : new byte[0]);
    }

    /**
     * Get raw data for a file hash
     * @param hash The hash to return data for
     * @param handler An object that will get called with the resulting data and media type
     */
    public void content(String hash, final Handlers.DataHandler handler) {
        node.fileContent(hash, new DataCallback() {
            @Override
            public void call(byte[] data, String media, Exception e) {
                if (e != null) {
                    handler.onError(e);
                    return;
                }
                try {
                    handler.onComplete(data, media);
                } catch (Exception exception) {
                    handler.onError(exception);
                }
            }
        });
    }

    /**
     * Helper function to return the most appropriate image data for a minimun image width
     * @param path The IPFS path that includes image data for various image sizes
     * @param minWidth The width of the image the data will be used for
     * @param handler An object that will get called with the resulting data and media type
     */
    public void imageContentForMinWidth(String path, long minWidth, final Handlers.DataHandler handler) {
        node.imageFileContentForMinWidth(path, minWidth, new DataCallback() {
            @Override
            public void call(byte[] data, String media, Exception e) {
                if (e != null) {
                    handler.onError(e);
                    return;
                }
                try {
                    handler.onComplete(data, media);
                } catch (Exception exception) {
                    handler.onError(exception);
                }
            }
        });
    }

}
