.class public Lcom/pyscript/manager/DashboardFragment;
.super Landroidx/fragment/app/Fragment;
.source "DashboardFragment.java"


# instance fields
.field private db:Lcom/pyscript/manager/DBHelper;

.field private handler:Landroid/os/Handler;

.field private metricsUpdater:Ljava/lang/Runnable;

.field private proxyPickerLauncher:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Landroid/content/Intent;",
            ">;"
        }
    .end annotation
.end field

.field private tvApiUrl:Landroid/widget/TextView;

.field private tvRunningBots:Landroid/widget/TextView;

.field private tvStoppedBots:Landroid/widget/TextView;

.field private tvTotalCpu:Landroid/widget/TextView;

.field private tvTotalRam:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 4
    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    .line 6
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/pyscript/manager/DashboardFragment;->handler:Landroid/os/Handler;

    .line 9
    new-instance v0, Lcom/pyscript/manager/DashboardFragment$1;

    invoke-direct {v0, p0}, Lcom/pyscript/manager/DashboardFragment$1;-><init>(Lcom/pyscript/manager/DashboardFragment;)V

    iput-object v0, p0, Lcom/pyscript/manager/DashboardFragment;->metricsUpdater:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/pyscript/manager/DashboardFragment;)V
    .locals 0
    .param p0, "x0"    # Lcom/pyscript/manager/DashboardFragment;

    .line 4
    invoke-direct {p0}, Lcom/pyscript/manager/DashboardFragment;->updateGlobalMetrics()V

    return-void
.end method

.method static synthetic access$100(Lcom/pyscript/manager/DashboardFragment;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/pyscript/manager/DashboardFragment;

    .line 4
    iget-object v0, p0, Lcom/pyscript/manager/DashboardFragment;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method private updateGlobalMetrics()V
    .locals 12

    .line 49
    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 50
    :cond_0
    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Landroidx/fragment/app/FragmentActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .local v0, "am":Landroid/app/ActivityManager;
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    .line 51
    .local v1, "myPid":I
    iget-object v2, p0, Lcom/pyscript/manager/DashboardFragment;->tvTotalRam:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "TOTAL RAM: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/4 v4, 0x1

    new-array v5, v4, [I

    const/4 v6, 0x0

    aput v1, v5, v6

    invoke-virtual {v0, v5}, Landroid/app/ActivityManager;->getProcessMemoryInfo([I)[Landroid/os/Debug$MemoryInfo;

    move-result-object v5

    aget-object v5, v5, v6

    invoke-virtual {v5}, Landroid/os/Debug$MemoryInfo;->getTotalPss()I

    move-result v5

    div-int/lit16 v5, v5, 0x400

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, " MB"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 52
    const/4 v2, 0x0

    .local v2, "totalCpu":F
    sget-object v3, Lcom/pyscript/manager/StatsManager;->cpuMap:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v3}, Ljava/util/concurrent/ConcurrentHashMap;->values()Ljava/util/Collection;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .local v5, "cpuStr":Ljava/lang/String;
    :try_start_0
    const-string v7, "%"

    const-string v8, ""

    invoke-virtual {v5, v7, v8}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v7
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-float/2addr v2, v7

    goto :goto_0

    :catch_0
    move-exception v7

    goto :goto_0

    .line 53
    .end local v5    # "cpuStr":Ljava/lang/String;
    :cond_1
    iget-object v3, p0, Lcom/pyscript/manager/DashboardFragment;->tvTotalCpu:Landroid/widget/TextView;

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v5

    aput-object v5, v4, v6

    const-string v5, "TOTAL CPU: %.1f%%"

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 54
    iget-object v3, p0, Lcom/pyscript/manager/DashboardFragment;->db:Lcom/pyscript/manager/DBHelper;

    invoke-virtual {v3}, Lcom/pyscript/manager/DBHelper;->getAllScripts()Ljava/util/List;

    move-result-object v3

    .local v3, "scripts":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    const/4 v4, 0x0

    .local v4, "running":I
    const/4 v5, 0x0

    .line 55
    .local v5, "stopped":I
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_1
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/pyscript/manager/ScriptModel;

    .local v8, "s":Lcom/pyscript/manager/ScriptModel;
    sget-object v9, Lcom/pyscript/manager/StatsManager;->isRunning:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v10, v8, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_2

    sget-object v9, Lcom/pyscript/manager/StatsManager;->isRunning:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v10, v8, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/Boolean;

    invoke-virtual {v9}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v9

    if-eqz v9, :cond_2

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 56
    .end local v8    # "s":Lcom/pyscript/manager/ScriptModel;
    :cond_3
    iget-object v7, p0, Lcom/pyscript/manager/DashboardFragment;->tvRunningBots:Landroid/widget/TextView;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "RUNNING BOTS: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v7, p0, Lcom/pyscript/manager/DashboardFragment;->tvStoppedBots:Landroid/widget/TextView;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "STOPPED BOTS: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 59
    :try_start_1
    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v7

    const-string v8, "wifi"

    invoke-virtual {v7, v8}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/net/wifi/WifiManager;

    .line 60
    .local v7, "wm":Landroid/net/wifi/WifiManager;
    invoke-virtual {v7}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v8

    invoke-virtual {v8}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v8

    invoke-static {v8}, Landroid/text/format/Formatter;->formatIpAddress(I)Ljava/lang/String;

    move-result-object v8

    .line 61
    .local v8, "ip":Ljava/lang/String;
    const-string v9, "0.0.0.0"

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    const-string v9, "127.0.0.1 (Localhost)"

    move-object v8, v9

    .line 62
    :cond_4
    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v9

    invoke-static {v9, v8}, Lcom/pyscript/manager/ApiControl;->statusText(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v10
    iget-object v9, p0, Lcom/pyscript/manager/DashboardFragment;->tvApiUrl:Landroid/widget/TextView;
    invoke-virtual {v9, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .end local v6    # "currentApiKey":Ljava/lang/String;
    .end local v7    # "wm":Landroid/net/wifi/WifiManager;
    .end local v8    # "ip":Ljava/lang/String;
    goto :goto_2

    .line 64
    :catch_1
    move-exception v6

    :goto_2
    nop

    .line 65
    return-void
.end method


# virtual methods
.method synthetic lambda$onCreate$0$com-pyscript-manager-DashboardFragment(Landroidx/activity/result/ActivityResult;)V
    .locals 8
    .param p1, "result"    # Landroidx/activity/result/ActivityResult;

    .line 14
    invoke-virtual {p1}, Landroidx/activity/result/ActivityResult;->getResultCode()I

    move-result v0

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    const/4 v1, -0x1

    if-ne v0, v1, :cond_2

    invoke-virtual {p1}, Landroidx/activity/result/ActivityResult;->getData()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 16
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {p1}, Landroidx/activity/result/ActivityResult;->getData()Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v1

    .line 17
    .local v1, "is":Ljava/io/InputStream;
    new-instance v2, Ljava/io/File;

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v3

    const-string v4, "pylibs"

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .local v2, "libsDir":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 18
    :cond_0
    new-instance v3, Ljava/io/FileOutputStream;

    new-instance v4, Ljava/io/File;

    const-string v5, "proxies.txt"

    invoke-direct {v4, v2, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v3, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 19
    .local v3, "fos":Ljava/io/FileOutputStream;
    const/16 v4, 0x400

    new-array v4, v4, [B

    .local v4, "buffer":[B
    :goto_0
    invoke-virtual {v1, v4}, Ljava/io/InputStream;->read([B)I

    move-result v5

    move v6, v5

    .local v6, "length":I
    if-lez v5, :cond_1

    invoke-virtual {v3, v4, v0, v6}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_0

    .line 20
    :cond_1
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v5

    const-string v7, "\u2705 Proxies Imported Successfully!"

    invoke-static {v5, v7, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v5

    invoke-virtual {v5}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 21
    .end local v1    # "is":Ljava/io/InputStream;
    .end local v2    # "libsDir":Ljava/io/File;
    .end local v3    # "fos":Ljava/io/FileOutputStream;
    .end local v4    # "buffer":[B
    .end local v6    # "length":I
    goto :goto_1

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "\u274c Error importing file."

    invoke-static {v2, v3, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 23
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_2
    :goto_1
    return-void
.end method

.method synthetic lambda$onCreateView$1$com-pyscript-manager-DashboardFragment(Landroid/view/View;)V
    .locals 6
    .param p1, "view"    # Landroid/view/View;

    .line 30
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "pylibs"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .local v0, "libsDir":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    :cond_0
    new-instance v1, Ljava/io/File;

    const-string v2, "proxies.txt"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    .local v1, "proxyPath":Ljava/lang/String;
    new-instance v3, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v4

    const-class v5, Lcom/pyscript/manager/EditorActivity;

    invoke-direct {v3, v4, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .local v3, "intent":Landroid/content/Intent;
    const-string v4, "path"

    invoke-virtual {v3, v4, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v4, "name"

    invoke-virtual {v3, v4, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v3}, Lcom/pyscript/manager/DashboardFragment;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method synthetic lambda$onCreateView$2$com-pyscript-manager-DashboardFragment(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .line 31
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "text/plain"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->proxyPickerLauncher:Landroidx/activity/result/ActivityResultLauncher;

    invoke-virtual {v1, v0}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    return-void
.end method

.method synthetic lambda$onCreateView$3$com-pyscript-manager-DashboardFragment(Landroid/view/View;)V
    .locals 4
    .param p1, "view"    # Landroid/view/View;

    .line 32
    sget-object v0, Lcom/pyscript/manager/StatsManager;->crashLogs:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "\u2705 All systems stable."

    goto :goto_0

    :cond_0
    const-string v0, "\n\n"

    sget-object v1, Lcom/pyscript/manager/StatsManager;->crashLogs:Ljava/util/List;

    invoke-static {v0, v1}, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticBackport0;->m(Ljava/lang/CharSequence;Ljava/lang/Iterable;)Ljava/lang/String;

    move-result-object v0

    .local v0, "alerts":Ljava/lang/String;
    :goto_0
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v2

    const v3, 0x10302d1

    invoke-direct {v1, v2, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    const-string v2, "\ud83d\udea8 Crash History"

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "OK"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    return-void
.end method

.method synthetic lambda$onCreateView$4$com-pyscript-manager-DashboardFragment(Landroid/widget/EditText;Landroid/view/View;)V
    .locals 3
    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;
    move-result-object v0
    invoke-static {v0}, Lcom/pyscript/manager/ApiControl;->rotateToken(Landroid/content/Context;)Ljava/lang/String;
    const-string v1, "API token regenerated. Update clients."
    const/4 v2, 0x0
    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    invoke-direct {p0}, Lcom/pyscript/manager/DashboardFragment;->updateGlobalMetrics()V
    return-void
.end method

.method synthetic lambda$onCreateView$5$com-pyscript-manager-DashboardFragment(Landroid/widget/EditText;Landroid/view/View;)V
    .locals 5
    .param p1, "etPkg"    # Landroid/widget/EditText;
    .param p2, "view"    # Landroid/view/View;

    .line 44
    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .local v0, "pkg":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v1

    new-instance v2, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    const-class v4, Lcom/pyscript/manager/ScriptService;

    invoke-direct {v2, v3, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v3, "action"

    const-string v4, "install"

    invoke-virtual {v2, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    const-string v3, "pkg"

    invoke-virtual {v2, v3, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    const-string v1, ""

    invoke-virtual {p1, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "Installing... Check Terminal!"

    const/4 v3, 0x1

    invoke-static {v1, v2, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    :cond_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 12
    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->onCreate(Landroid/os/Bundle;)V

    .line 13
    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;

    invoke-direct {v0}, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;-><init>()V

    new-instance v1, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda6;-><init>(Lcom/pyscript/manager/DashboardFragment;)V

    invoke-virtual {p0, v0, v1}, Lcom/pyscript/manager/DashboardFragment;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/pyscript/manager/DashboardFragment;->proxyPickerLauncher:Landroidx/activity/result/ActivityResultLauncher;

    .line 24
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 5
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .line 27
    const v0, 0x7f0b002e

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 28
    .local v0, "v":Landroid/view/View;
    const v1, 0x7f0801fc

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->tvTotalRam:Landroid/widget/TextView;

    const v1, 0x7f0801fb

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->tvTotalCpu:Landroid/widget/TextView;

    const v1, 0x7f0801f8

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->tvRunningBots:Landroid/widget/TextView;

    const v1, 0x7f0801f9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->tvStoppedBots:Landroid/widget/TextView;

    const v1, 0x7f0801f7

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->tvApiUrl:Landroid/widget/TextView;

    new-instance v1, Lcom/pyscript/manager/DBHelper;

    invoke-virtual {p0}, Lcom/pyscript/manager/DashboardFragment;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/pyscript/manager/DBHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->db:Lcom/pyscript/manager/DBHelper;

    .line 30
    const v1, 0x7f080065

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    new-instance v2, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda1;

    invoke-direct {v2, p0}, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda1;-><init>(Lcom/pyscript/manager/DashboardFragment;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 31
    const v1, 0x7f080066

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    new-instance v2, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda2;

    invoke-direct {v2, p0}, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda2;-><init>(Lcom/pyscript/manager/DashboardFragment;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 32
    const v1, 0x7f08006f

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    new-instance v2, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda3;

    invoke-direct {v2, p0}, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda3;-><init>(Lcom/pyscript/manager/DashboardFragment;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 34
    const v1, 0x7f0800c2

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    .line 35
    .local v1, "etApiKey":Landroid/widget/EditText;
    const v2, 0x7f08006c

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    new-instance v3, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda4;

    invoke-direct {v3, p0, v1}, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda4;-><init>(Lcom/pyscript/manager/DashboardFragment;Landroid/widget/EditText;)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 43
    const v2, 0x7f0800c3

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/EditText;

    .line 44
    .local v2, "etPkg":Landroid/widget/EditText;
    const v3, 0x7f080067

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    new-instance v4, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda5;

    invoke-direct {v4, p0, v2}, Lcom/pyscript/manager/DashboardFragment$$ExternalSyntheticLambda5;-><init>(Lcom/pyscript/manager/DashboardFragment;Landroid/widget/EditText;)V

    invoke-virtual {v3, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 45
    iget-object v3, p0, Lcom/pyscript/manager/DashboardFragment;->handler:Landroid/os/Handler;

    iget-object v4, p0, Lcom/pyscript/manager/DashboardFragment;->metricsUpdater:Ljava/lang/Runnable;

    invoke-virtual {v3, v4}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-object v0
.end method

.method public onDestroyView()V
    .locals 2

    .line 66
    invoke-super {p0}, Landroidx/fragment/app/Fragment;->onDestroyView()V

    iget-object v0, p0, Lcom/pyscript/manager/DashboardFragment;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/pyscript/manager/DashboardFragment;->metricsUpdater:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method
