.class public Lcom/pyscript/manager/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 4
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method synthetic lambda$onCreate$0$com-pyscript-manager-MainActivity(Landroid/view/MenuItem;)Z
    .locals 4
    .param p1, "item"    # Landroid/view/MenuItem;

    .line 25
    const/4 v0, 0x0

    .local v0, "selected":Landroidx/fragment/app/Fragment;
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v1

    .local v1, "id":I
    const v2, 0x7f080146

    if-ne v1, v2, :cond_0

    new-instance v2, Lcom/pyscript/manager/DashboardFragment;

    invoke-direct {v2}, Lcom/pyscript/manager/DashboardFragment;-><init>()V

    :goto_0
    move-object v0, v2

    goto :goto_1

    :cond_0
    const v2, 0x7f080147

    if-ne v1, v2, :cond_1

    new-instance v2, Lcom/pyscript/manager/ScriptsFragment;

    invoke-direct {v2}, Lcom/pyscript/manager/ScriptsFragment;-><init>()V

    goto :goto_0

    :cond_1
    const v2, 0x7f080148

    if-ne v1, v2, :cond_2

    new-instance v2, Lcom/pyscript/manager/TerminalFragment;

    invoke-direct {v2}, Lcom/pyscript/manager/TerminalFragment;-><init>()V

    goto :goto_0

    :cond_2
    :goto_1
    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/pyscript/manager/MainActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v2

    const v3, 0x7f0800d8

    invoke-virtual {v2, v3, v0}, Landroidx/fragment/app/FragmentTransaction;->replace(ILandroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/fragment/app/FragmentTransaction;->commit()I

    :cond_3
    const/4 v2, 0x1

    return v2
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 6
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    const v0, 0x7f0b001d

    invoke-virtual {p0, v0}, Lcom/pyscript/manager/MainActivity;->setContentView(I)V

    .line 9
    nop

    .line 10
    const-string v0, "power"

    invoke-virtual {p0, v0}, Lcom/pyscript/manager/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/PowerManager;

    .line 11
    .local v0, "pm":Landroid/os/PowerManager;
    invoke-virtual {p0}, Lcom/pyscript/manager/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/PowerManager;->isIgnoringBatteryOptimizations(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 12
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 13
    .local v1, "intent":Landroid/content/Intent;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "package:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/pyscript/manager/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    invoke-virtual {p0, v1}, Lcom/pyscript/manager/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 18
    .end local v0    # "pm":Landroid/os/PowerManager;
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_1

    .line 19
    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Lcom/pyscript/manager/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_1

    .line 20
    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x65

    invoke-virtual {p0, v0, v1}, Lcom/pyscript/manager/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 24
    :cond_1
    const v0, 0x7f08005e

    invoke-virtual {p0, v0}, Lcom/pyscript/manager/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/google/android/material/bottomnavigation/BottomNavigationView;

    .line 25
    .local v0, "nav":Lcom/google/android/material/bottomnavigation/BottomNavigationView;
    new-instance v1, Lcom/pyscript/manager/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/pyscript/manager/MainActivity$$ExternalSyntheticLambda0;-><init>(Lcom/pyscript/manager/MainActivity;)V

    invoke-virtual {v0, v1}, Lcom/google/android/material/bottomnavigation/BottomNavigationView;->setOnItemSelectedListener(Lcom/google/android/material/navigation/NavigationBarView$OnItemSelectedListener;)V

    .line 26
    invoke-virtual {p0}, Lcom/pyscript/manager/MainActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    new-instance v2, Lcom/pyscript/manager/DashboardFragment;

    invoke-direct {v2}, Lcom/pyscript/manager/DashboardFragment;-><init>()V

    const v3, 0x7f0800d8

    invoke-virtual {v1, v3, v2}, Landroidx/fragment/app/FragmentTransaction;->replace(ILandroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentTransaction;->commit()I

    .line 27
    return-void
.end method

.method public toggleApi(Landroid/view/View;)V
    .locals 5
    invoke-virtual {p0}, Lcom/pyscript/manager/MainActivity;->getApplication()Landroid/app/Application;
    move-result-object v0
    check-cast v0, Lcom/pyscript/manager/App;
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->isEnabled(Landroid/content/Context;)Z
    move-result v1
    if-nez v1, :disable
    const/4 v2, 0x1
    goto :set
    :disable
    const/4 v2, 0x0
    :set
    invoke-virtual {v0, v2}, Lcom/pyscript/manager/App;->setApiEnabled(Z)Z
    move-result v3
    if-eqz v3, :off_or_failed
    const-string v4, "API enabled on port 8080"
    goto :toast
    :off_or_failed
    if-eqz v2, :off
    const-string v4, "Could not start API; port may be in use"
    goto :toast
    :off
    const-string v4, "API disabled"
    :toast
    const/4 v2, 0x0
    invoke-static {p0, v4, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    return-void
.end method
