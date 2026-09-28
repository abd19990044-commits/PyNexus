.class public final Lcom/pyscript/manager/ApiControl;
.super Ljava/lang/Object;
.source "ApiControl.java"

.method private constructor <init>()V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method private static prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    .locals 2
    const-string v0, "ApiPrefs"
    const/4 v1, 0x0
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    return-object v0
.end method

.method private static generateToken()Ljava/lang/String;
    .locals 9
    const/16 v0, 0x18
    new-array v0, v0, [B
    new-instance v1, Ljava/security/SecureRandom;
    invoke-direct {v1}, Ljava/security/SecureRandom;-><init>()V
    invoke-virtual {v1, v0}, Ljava/security/SecureRandom;->nextBytes([B)V
    const-string v1, "0123456789abcdef"
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "py-"
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    const/4 v3, 0x0
    array-length v4, v0
    :loop
    if-ge v3, v4, :done
    aget-byte v5, v0, v3
    and-int/lit16 v5, v5, 0xff
    shr-int/lit8 v6, v5, 0x4
    invoke-virtual {v1, v6}, Ljava/lang/String;->charAt(I)C
    move-result v7
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    and-int/lit8 v6, v5, 0xf
    invoke-virtual {v1, v6}, Ljava/lang/String;->charAt(I)C
    move-result v7
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    add-int/lit8 v3, v3, 0x1
    goto :loop
    :done
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    return-object v8
.end method

.method public static ensureKey(Landroid/content/Context;)Ljava/lang/String;
    .locals 4
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, "api_key"
    const/4 v2, 0x0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :new_key
    const-string v3, "py-[A-Za-z0-9]{12,}"
    invoke-virtual {v2, v3}, Ljava/lang/String;->matches(Ljava/lang/String;)Z
    move-result v3
    if-nez v3, :done
    :new_key
    invoke-static {}, Lcom/pyscript/manager/ApiControl;->generateToken()Ljava/lang/String;
    move-result-object v2
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z
    :done
    return-object v2
.end method

.method public static rotateToken(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    invoke-static {}, Lcom/pyscript/manager/ApiControl;->generateToken()Ljava/lang/String;
    move-result-object v0
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v1
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v1
    const-string v2, "api_key"
    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    move-result-object v1
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z
    return-object v0
.end method

.method public static isEnabled(Landroid/content/Context;)Z
    .locals 3
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->prefs(Landroid/content/Context;)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, "api_enabled"
    const/4 v2, 0x0
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v2
    return v2
.end method

.method public static authorized(Landroid/content/Context;Lfi/iki/elonen/NanoHTTPD$IHTTPSession;)Z
    .locals 6
    const/4 v0, 0x0
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->isEnabled(Landroid/content/Context;)Z
    move-result v1
    if-eqz v1, :deny
    invoke-interface {p1}, Lfi/iki/elonen/NanoHTTPD$IHTTPSession;->getHeaders()Ljava/util/Map;
    move-result-object v1
    const-string v2, "authorization"
    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Ljava/lang/String;
    if-eqz v1, :deny
    const-string v2, "Bearer "
    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v3
    if-eqz v3, :deny
    const/4 v2, 0x7
    invoke-virtual {v1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v1
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->ensureKey(Landroid/content/Context;)Ljava/lang/String;
    move-result-object v2
    const-string v3, "UTF-8"
    :try_start
    invoke-virtual {v1, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v4
    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v5
    invoke-static {v4, v5}, Ljava/security/MessageDigest;->isEqual([B[B)Z
    move-result v0
    :try_end
    .catch Ljava/io/UnsupportedEncodingException; {:try_start .. :try_end} :deny
    :deny
    return v0
.end method

.method public static safeRequest(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;)Z
    .locals 12
    const/4 v0, 0x0
    const/4 v1, 0x1
    const-string v2, "/api/upload"
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :check_path
    const-string v2, "filename"
    invoke-interface {p2, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/String;
    if-eqz v2, :reject
    const-string v3, "[A-Za-z0-9_-][A-Za-z0-9_.-]{0,63}"
    invoke-virtual {v2, v3}, Ljava/lang/String;->matches(Ljava/lang/String;)Z
    move-result v2
    return v2
    :check_path
    const-string v2, "/api/run"
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :validate_path
    const-string v2, "/api/stop"
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :validate_path
    const-string v2, "/api/rst"
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :validate_path
    const-string v2, "/api/delete"
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :validate_path
    const-string v2, "/api/terminal_output"
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :validate_path
    return v1
    :validate_path
    const-string v2, "path"
    invoke-interface {p2, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/String;
    if-eqz v2, :reject
    const-string v3, ".py"
    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v3
    if-eqz v3, :reject
    :try_start
    invoke-virtual {p0, v0}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;
    move-result-object v3
    if-eqz v3, :reject_try
    invoke-virtual {v3}, Ljava/io/File;->getCanonicalFile()Ljava/io/File;
    move-result-object v3
    new-instance v4, Ljava/io/File;
    invoke-direct {v4, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4}, Ljava/io/File;->getCanonicalFile()Ljava/io/File;
    move-result-object v4
    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;
    move-result-object v5
    invoke-virtual {v3, v5}, Ljava/io/File;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :reject_try
    new-instance v6, Lcom/pyscript/manager/DBHelper;
    invoke-direct {v6, p0}, Lcom/pyscript/manager/DBHelper;-><init>(Landroid/content/Context;)V
    invoke-virtual {v6}, Lcom/pyscript/manager/DBHelper;->getAllScripts()Ljava/util/List;
    move-result-object v7
    invoke-virtual {v6}, Lcom/pyscript/manager/DBHelper;->close()V
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v8
    :loop
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z
    move-result v9
    if-eqz v9, :reject_try
    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v9
    check-cast v9, Lcom/pyscript/manager/ScriptModel;
    iget-object v9, v9, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;
    new-instance v10, Ljava/io/File;
    invoke-direct {v10, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    invoke-virtual {v10}, Ljava/io/File;->getCanonicalFile()Ljava/io/File;
    move-result-object v10
    invoke-virtual {v4, v10}, Ljava/io/File;->equals(Ljava/lang/Object;)Z
    move-result v11
    if-eqz v11, :loop
    return v1
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :caught
    :reject_try
    :reject
    return v0
    :caught
    move-exception v2
    goto :reject
.end method

.method public static statusText(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->isEnabled(Landroid/content/Context;)Z
    move-result v1
    if-eqz v1, :off
    const-string v2, "API: ON"
    goto :label
    :off
    const-string v2, "API: OFF"
    :label
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, "\nURL: http://"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, ":8080\nToken: "
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-static {p0}, Lcom/pyscript/manager/ApiControl;->ensureKey(Landroid/content/Context;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v2, "\nUse Authorization: Bearer <token> (LAN HTTP)"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method
