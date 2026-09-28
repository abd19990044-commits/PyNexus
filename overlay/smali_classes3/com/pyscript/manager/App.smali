.class public Lcom/pyscript/manager/App;
.super Landroid/app/Application;
.source "App.java"


# instance fields
.field private apiServer:Lcom/pyscript/manager/ApiServer;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreate()V
    .locals 2

    .line 11
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 12
    invoke-static {}, Lcom/chaquo/python/Python;->isStarted()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Lcom/chaquo/python/android/AndroidPlatform;

    invoke-direct {v0, p0}, Lcom/chaquo/python/android/AndroidPlatform;-><init>(Landroid/content/Context;)V

    invoke-static {v0}, Lcom/chaquo/python/Python;->start(Lcom/chaquo/python/Python$Platform;)V

    :cond_0
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->ensureKey(Landroid/content/Context;)Ljava/lang/String;
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->isEnabled(Landroid/content/Context;)Z
    move-result v0
    if-eqz v0, :api_disabled
    const/4 v0, 0x1
    invoke-virtual {p0, v0}, Lcom/pyscript/manager/App;->setApiEnabled(Z)Z
    :api_disabled
    return-void
.end method

.method public synchronized setApiEnabled(Z)Z
    .locals 4
    if-eqz p1, :turn_off
    iget-object v0, p0, Lcom/pyscript/manager/App;->apiServer:Lcom/pyscript/manager/ApiServer;
    if-nez v0, :save_state
    :try_start
    new-instance v0, Lcom/pyscript/manager/ApiServer;
    invoke-direct {v0, p0}, Lcom/pyscript/manager/ApiServer;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/pyscript/manager/App;->apiServer:Lcom/pyscript/manager/ApiServer;
    :try_end
    .catch Ljava/io/IOException; {:try_start .. :try_end} :start_failed
    goto :save_state
    :start_failed
    move-exception v0
    const/4 p1, 0x0
    goto :save_state
    :turn_off
    iget-object v0, p0, Lcom/pyscript/manager/App;->apiServer:Lcom/pyscript/manager/ApiServer;
    if-eqz v0, :save_state
    invoke-virtual {v0}, Lcom/pyscript/manager/ApiServer;->stop()V
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/pyscript/manager/App;->apiServer:Lcom/pyscript/manager/ApiServer;
    :save_state
    const-string v0, "ApiPrefs"
    const/4 v1, 0x0
    invoke-virtual {p0, v0, v1}, Lcom/pyscript/manager/App;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v2
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    const-string v3, "api_enabled"
    invoke-interface {v2, v3, p1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->commit()Z
    return p1
.end method
