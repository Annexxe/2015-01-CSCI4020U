.class public Hello
.super java/lang/Object

.method public <init>()V
    aload_0
    invokenonvirtual java/lang/Object/<init>()V
    return
.end method

.method public static main([Ljava/lang/String;)V
    .limit stack 10
    .limit locals 1

    getstatic java/lang/System/out Ljava/io/PrintStream;
    ldc "Hello World"
    invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
    return
.end method
