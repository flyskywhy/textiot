package io.textile.rnmobile;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import io.textile.pb.Model;
import io.textile.textile.Handlers;
import io.textile.textile.Textile;

public class IpfsBridge extends ReactContextBaseJavaModule {

    private Executor executor = Executors.newCachedThreadPool();

    public IpfsBridge(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "IpfsBridge";
    }

    @ReactMethod
    public void peerId(final Promise promise) {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    promise.resolve(Textile.instance().ipfs.peerId());
                }
                catch (final Exception e) {
                    promise.reject("peerId", e);
                }
            }
        });
    }

    @ReactMethod
    public void connect(final String multiaddr, final Promise promise) {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    if (Textile.instance().ipfs.swarmConnect(multiaddr)) {
                        promise.resolve(true);
                    } else {
                        promise.reject(new Exception("connect"));
                    }
                }
                catch (final Exception e) {
                    promise.reject("connect", e);
                }
            }
        });
    }

    @ReactMethod
    public void peers(final boolean verbose, final boolean latency, final boolean streams, final boolean direction, final Promise promise) {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    final Model.SwarmPeerList list = Textile.instance().ipfs.swarmPeers(verbose, latency, streams, direction);
                    promise.resolve(Util.encode(list.toByteArray()));
                }
                catch (final Exception e) {
                    promise.reject("peers", e);
                }
            }
        });
    }

    @ReactMethod
    public void dataAtPath(final String path, final Promise promise) {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                Textile.instance().ipfs.dataAtPath(path, new Handlers.DataHandler() {
                    @Override
                    public void onComplete(final byte[] data, final String media) {
                        promise.resolve(Util.encodeData(data, media));
                    }

                    @Override
                    public void onError(final Exception e) {
                        promise.reject("dataAtPath", e);
                    }
                });
            }
        });
    }

    @ReactMethod
    public void pubsubPub(final String topic, final String data, final Promise promise) {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    Textile.instance().ipfs.pubsubPub(topic, data);
                    promise.resolve(true);
                }
                catch (final Exception e) {
                    promise.reject("pubsubPub", e);
                }
            }
        });
    }

    @ReactMethod
    public void pubsubSub(final String topic, final Promise promise) {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    String queryId = Textile.instance().ipfs.pubsubSub(topic);
                    promise.resolve(queryId);
                }
                catch (final Exception e) {
                    promise.reject("pubsubSub", e);
                }
            }
        });
    }

    @ReactMethod
    public void cancelPubsubSub(final String queryId, final Promise promise) {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                Textile.instance().ipfs.cancelPubsubSub(queryId);
                promise.resolve(null);
            }
        });
    }
}
