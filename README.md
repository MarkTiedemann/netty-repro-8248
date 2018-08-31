# netty-repro-8248

**See [https://github.com/netty/netty/issues/8248](https://github.com/netty/netty/issues/8248).**

## Reproduction

1. Open your terminal and run `powershell -f reproduce.ps1`.

2. As soon as the server has started, run `curl localhost` up to 10 times in a second terminal.

3. Check the output of the first terminal. After a few requests, the `java.lang.OutOfMemoryError: Direct buffer memory` should occur (see example output below).

```
openjdk 10.0.2-adoptopenjdk 2018-07-17
OpenJDK Runtime Environment (build 10.0.2-adoptopenjdk+13)
Eclipse OpenJ9 VM (build openj9-0.9.0, JRE 10 Windows 8.1 amd64-64-Bit Compressed References 20180813_95 (JIT enabled, AOT enabled)
OpenJ9   - 24e53631
OMR      - fad6bf6e
JCL      - 7db90eda56 based on jdk-10.0.2+13)
Sep 01, 2018 1:40:44 AM io.netty.handler.logging.LoggingHandler channelRegistered
INFO: [id: 0x767adea8] REGISTERED
Sep 01, 2018 1:40:44 AM io.netty.handler.logging.LoggingHandler bind
INFO: [id: 0x767adea8] BIND: 0.0.0.0/0.0.0.0:80
Sep 01, 2018 1:40:45 AM io.netty.handler.logging.LoggingHandler channelActive
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] ACTIVE
Sep 01, 2018 1:40:48 AM io.netty.handler.logging.LoggingHandler channelRead
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ: [id: 0xf5ae90fe, L:/0:0:0:0:0:0:0:1:80 - R:/0:0:0:0:0:0:0:1:56445]
Sep 01, 2018 1:40:48 AM io.netty.handler.logging.LoggingHandler channelReadComplete
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ COMPLETE
Sep 01, 2018 1:40:50 AM io.netty.handler.logging.LoggingHandler channelRead
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ: [id: 0x26f8ab28, L:/0:0:0:0:0:0:0:1:80 - R:/0:0:0:0:0:0:0:1:56446]
Sep 01, 2018 1:40:50 AM io.netty.handler.logging.LoggingHandler channelReadComplete
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ COMPLETE
Sep 01, 2018 1:40:53 AM io.netty.handler.logging.LoggingHandler channelRead
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ: [id: 0xfe3fffe9, L:/0:0:0:0:0:0:0:1:80 - R:/0:0:0:0:0:0:0:1:56447]
Sep 01, 2018 1:40:53 AM io.netty.handler.logging.LoggingHandler channelReadComplete
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ COMPLETE
Sep 01, 2018 1:40:55 AM io.netty.handler.logging.LoggingHandler channelRead
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ: [id: 0x5b28d7a4, L:/0:0:0:0:0:0:0:1:80 - R:/0:0:0:0:0:0:0:1:56448]
Sep 01, 2018 1:40:55 AM io.netty.handler.logging.LoggingHandler channelReadComplete
INFO: [id: 0x767adea8, L:/0:0:0:0:0:0:0:0:80] READ COMPLETE
java.lang.OutOfMemoryError: Direct buffer memory
        at java.nio.Bits.reserveMemory(java.base@10.0.2-adoptopenjdk/Bits.java:187)
        at java.nio.DirectByteBuffer.<init>(java.base@10.0.2-adoptopenjdk/DirectByteBuffer.java:129)
        at java.nio.ByteBuffer.allocateDirect(java.base@10.0.2-adoptopenjdk/ByteBuffer.java:310)
        at io.netty.buffer.PoolArena$DirectArena.allocateDirect(PoolArena.java:764)
        at io.netty.buffer.PoolArena$DirectArena.newChunk(PoolArena.java:740)
        at io.netty.buffer.PoolArena.allocateNormal(PoolArena.java:244)
        at io.netty.buffer.PoolArena.allocate(PoolArena.java:214)
        at io.netty.buffer.PoolArena.allocate(PoolArena.java:146)
        at io.netty.buffer.PooledByteBufAllocator.newDirectBuffer(PooledByteBufAllocator.java:324)
        at io.netty.buffer.AbstractByteBufAllocator.directBuffer(AbstractByteBufAllocator.java:185)
        at io.netty.buffer.AbstractByteBufAllocator.directBuffer(AbstractByteBufAllocator.java:176)
        at io.netty.buffer.AbstractByteBufAllocator.ioBuffer(AbstractByteBufAllocator.java:137)
        at io.netty.channel.DefaultMaxMessagesRecvByteBufAllocator$MaxMessageHandle.allocate(DefaultMaxMessagesRecvByteBufAllocator.java:114)
        at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:147)
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:628)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysPlain(NioEventLoop.java:528)
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:482)
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:442)
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:884)
        at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
        at java.lang.Thread.run(java.base@10.0.2-adoptopenjdk/Thread.java:835)
```