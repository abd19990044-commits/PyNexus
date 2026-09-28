.class public Lcom/pyscript/manager/ScriptsFragment;
.super Landroidx/fragment/app/Fragment;
.source "ScriptsFragment.java"


# instance fields
.field private adapter:Lcom/pyscript/manager/ScriptAdapter;

.field private db:Lcom/pyscript/manager/DBHelper;

.field private filePickerLauncher:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Landroid/content/Intent;",
            ">;"
        }
    .end annotation
.end field

.field private handler:Landroid/os/Handler;

.field private rv:Landroidx/recyclerview/widget/RecyclerView;

.field private statsUpdater:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 3
    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    .line 4
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/pyscript/manager/ScriptsFragment;->handler:Landroid/os/Handler;

    .line 5
    new-instance v0, Lcom/pyscript/manager/ScriptsFragment$1;

    invoke-direct {v0, p0}, Lcom/pyscript/manager/ScriptsFragment$1;-><init>(Lcom/pyscript/manager/ScriptsFragment;)V

    iput-object v0, p0, Lcom/pyscript/manager/ScriptsFragment;->statsUpdater:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic access$000(Lcom/pyscript/manager/ScriptsFragment;)Landroidx/recyclerview/widget/RecyclerView;
    .locals 1
    .param p0, "x0"    # Lcom/pyscript/manager/ScriptsFragment;

    .line 3
    iget-object v0, p0, Lcom/pyscript/manager/ScriptsFragment;->rv:Landroidx/recyclerview/widget/RecyclerView;

    return-object v0
.end method

.method static synthetic access$100(Lcom/pyscript/manager/ScriptsFragment;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/pyscript/manager/ScriptsFragment;

    .line 3
    iget-object v0, p0, Lcom/pyscript/manager/ScriptsFragment;->handler:Landroid/os/Handler;

    return-object v0
.end method

.method private importFile(Landroid/net/Uri;)V
    .locals 11
    .param p1, "uri"    # Landroid/net/Uri;

    .line 7
    const-string v0, ".py"

    :try_start_0
    const-string v1, "imported_script.py"

    .local v1, "fileName":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v4, p1

    invoke-virtual/range {v3 .. v8}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v2

    .local v2, "cursor":Landroid/database/Cursor;
    if-eqz v2, :cond_1

    invoke-interface {v2}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "_display_name"

    invoke-interface {v2, v3}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v3

    .local v3, "nameIndex":I
    const/4 v4, -0x1

    if-eq v3, v4, :cond_0

    invoke-interface {v2, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    move-object v1, v4

    :cond_0
    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .end local v3    # "nameIndex":I
    :cond_1
    invoke-virtual {v1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v1, v0

    :cond_2
    const-string v3, "[A-Za-z0-9_-][A-Za-z0-9_.-]{0,63}\\.py"
    invoke-virtual {v1, v3}, Ljava/lang/String;->matches(Ljava/lang/String;)Z
    move-result v3
    if-nez v3, :valid_import_name
    new-instance v3, Ljava/io/IOException;
    const-string v4, "Invalid script filename"
    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V
    throw v3
    :valid_import_name
    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v0

    .local v0, "is":Ljava/io/InputStream;
    new-instance v3, Ljava/io/File;

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getContext()Landroid/content/Context;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v4

    invoke-direct {v3, v4, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .local v3, "file":Ljava/io/File;
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .local v4, "fos":Ljava/io/FileOutputStream;
    const/16 v5, 0x400

    new-array v5, v5, [B

    .local v5, "buffer":[B
    :goto_0
    invoke-virtual {v0, v5}, Ljava/io/InputStream;->read([B)I

    move-result v6

    move v7, v6

    .local v7, "length":I
    const/4 v8, 0x0

    if-lez v6, :cond_3

    invoke-virtual {v4, v5, v8, v7}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_0

    :cond_3
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    iget-object v6, p0, Lcom/pyscript/manager/ScriptsFragment;->db:Lcom/pyscript/manager/DBHelper;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v1, v9}, Lcom/pyscript/manager/DBHelper;->addScript(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->onResume()V

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getContext()Landroid/content/Context;

    move-result-object v6

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Imported: "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v6, v9, v8}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "is":Ljava/io/InputStream;
    .end local v1    # "fileName":Ljava/lang/String;
    .end local v2    # "cursor":Landroid/database/Cursor;
    .end local v3    # "file":Ljava/io/File;
    .end local v4    # "fos":Ljava/io/FileOutputStream;
    .end local v5    # "buffer":[B
    .end local v7    # "length":I
    goto :goto_1

    :catch_0
    move-exception v0

    :goto_1
    return-void
.end method


# virtual methods
.method synthetic lambda$onCreate$0$com-pyscript-manager-ScriptsFragment(Landroidx/activity/result/ActivityResult;)V
    .locals 2
    .param p1, "result"    # Landroidx/activity/result/ActivityResult;

    .line 6
    invoke-virtual {p1}, Landroidx/activity/result/ActivityResult;->getResultCode()I

    move-result v0

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    invoke-virtual {p1}, Landroidx/activity/result/ActivityResult;->getData()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroidx/activity/result/ActivityResult;->getData()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/pyscript/manager/ScriptsFragment;->importFile(Landroid/net/Uri;)V

    :cond_0
    return-void
.end method

.method synthetic lambda$onCreateView$1$com-pyscript-manager-ScriptsFragment(Landroid/view/View;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .line 8
    new-instance v0, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    const-class v2, Lcom/pyscript/manager/EditorActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/pyscript/manager/ScriptsFragment;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method synthetic lambda$onCreateView$2$com-pyscript-manager-ScriptsFragment(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .line 8
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Lcom/pyscript/manager/ScriptsFragment;->filePickerLauncher:Landroidx/activity/result/ActivityResultLauncher;

    invoke-virtual {v1, v0}, Landroidx/activity/result/ActivityResultLauncher;->launch(Ljava/lang/Object;)V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 6
    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->onCreate(Landroid/os/Bundle;)V

    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;

    invoke-direct {v0}, Landroidx/activity/result/contract/ActivityResultContracts$StartActivityForResult;-><init>()V

    new-instance v1, Lcom/pyscript/manager/ScriptsFragment$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/pyscript/manager/ScriptsFragment$$ExternalSyntheticLambda0;-><init>(Lcom/pyscript/manager/ScriptsFragment;)V

    invoke-virtual {p0, v0, v1}, Lcom/pyscript/manager/ScriptsFragment;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/pyscript/manager/ScriptsFragment;->filePickerLauncher:Landroidx/activity/result/ActivityResultLauncher;

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 4
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .line 8
    const v0, 0x7f0b002f

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .local v0, "v":Landroid/view/View;
    const v1, 0x7f080175

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    iput-object v1, p0, Lcom/pyscript/manager/ScriptsFragment;->rv:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v2, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    new-instance v1, Lcom/pyscript/manager/DBHelper;

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/pyscript/manager/DBHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/pyscript/manager/ScriptsFragment;->db:Lcom/pyscript/manager/DBHelper;

    const v1, 0x7f0800c8

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    new-instance v2, Lcom/pyscript/manager/ScriptsFragment$$ExternalSyntheticLambda1;

    invoke-direct {v2, p0}, Lcom/pyscript/manager/ScriptsFragment$$ExternalSyntheticLambda1;-><init>(Lcom/pyscript/manager/ScriptsFragment;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0800c9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    new-instance v2, Lcom/pyscript/manager/ScriptsFragment$$ExternalSyntheticLambda2;

    invoke-direct {v2, p0}, Lcom/pyscript/manager/ScriptsFragment$$ExternalSyntheticLambda2;-><init>(Lcom/pyscript/manager/ScriptsFragment;)V

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lcom/pyscript/manager/ScriptsFragment;->handler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/pyscript/manager/ScriptsFragment;->statsUpdater:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-object v0
.end method

.method public onDestroyView()V
    .locals 2

    .line 10
    invoke-super {p0}, Landroidx/fragment/app/Fragment;->onDestroyView()V

    iget-object v0, p0, Lcom/pyscript/manager/ScriptsFragment;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/pyscript/manager/ScriptsFragment;->statsUpdater:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onResume()V
    .locals 4

    .line 9
    invoke-super {p0}, Landroidx/fragment/app/Fragment;->onResume()V

    new-instance v0, Lcom/pyscript/manager/ScriptAdapter;

    iget-object v1, p0, Lcom/pyscript/manager/ScriptsFragment;->db:Lcom/pyscript/manager/DBHelper;

    invoke-virtual {v1}, Lcom/pyscript/manager/DBHelper;->getAllScripts()Ljava/util/List;

    move-result-object v1

    invoke-virtual {p0}, Lcom/pyscript/manager/ScriptsFragment;->getContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p0, Lcom/pyscript/manager/ScriptsFragment;->db:Lcom/pyscript/manager/DBHelper;

    invoke-direct {v0, v1, v2, v3}, Lcom/pyscript/manager/ScriptAdapter;-><init>(Ljava/util/List;Landroid/content/Context;Lcom/pyscript/manager/DBHelper;)V

    iput-object v0, p0, Lcom/pyscript/manager/ScriptsFragment;->adapter:Lcom/pyscript/manager/ScriptAdapter;

    iget-object v1, p0, Lcom/pyscript/manager/ScriptsFragment;->rv:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v0}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    return-void
.end method
