.class public Lcom/pyscript/manager/ApiServer;
.super Lfi/iki/elonen/NanoHTTPD;
.source "ApiServer.java"


# instance fields
.field private ctx:Landroid/content/Context;

.field private db:Lcom/pyscript/manager/DBHelper;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "ctx"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 16
    const/16 v0, 0x1f90

    invoke-direct {p0, v0}, Lfi/iki/elonen/NanoHTTPD;-><init>(I)V

    iput-object p1, p0, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    new-instance v0, Lcom/pyscript/manager/DBHelper;

    invoke-direct {v0, p1}, Lcom/pyscript/manager/DBHelper;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    const/16 v0, 0x1388

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/pyscript/manager/ApiServer;->start(IZ)V

    return-void
.end method

.method private createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;
    .locals 3
    .param p1, "status"    # Lfi/iki/elonen/NanoHTTPD$Response$Status;
    .param p2, "json"    # Ljava/lang/String;

    .line 17
    const-string v0, "application/json"

    invoke-static {p1, v0, p2}, Lcom/pyscript/manager/ApiServer;->newFixedLengthResponse(Lfi/iki/elonen/NanoHTTPD$Response$IStatus;Ljava/lang/String;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v0

    .local v0, "res":Lfi/iki/elonen/NanoHTTPD$Response;
    const-string v1, "Cache-Control"

    const-string v2, "no-store"

    invoke-virtual {v0, v1, v2}, Lfi/iki/elonen/NanoHTTPD$Response;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public serve(Lfi/iki/elonen/NanoHTTPD$IHTTPSession;)Lfi/iki/elonen/NanoHTTPD$Response;
    .locals 44
    .param p1, "session"    # Lfi/iki/elonen/NanoHTTPD$IHTTPSession;

    move-object/from16 v2, p0
    iget-object v0, v2, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;
    move-object/from16 v1, p1
    invoke-static {v0, v1}, Lcom/pyscript/manager/ApiControl;->authorized(Landroid/content/Context;Lfi/iki/elonen/NanoHTTPD$IHTTPSession;)Z
    move-result v0
    if-nez v0, :authenticated
    sget-object v0, Lfi/iki/elonen/NanoHTTPD$Response$Status;->UNAUTHORIZED:Lfi/iki/elonen/NanoHTTPD$Response$Status;
    const-string v1, "{\"error\":\"unauthorized or API disabled\"}"
    invoke-direct {v2, v0, v1}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;
    move-result-object v0
    return-object v0
    :authenticated
    .line 20
    move-object/from16 v1, p0

    const-string v2, ".py"

    const-string v3, "cmd"

    const-string v4, "\"}"

    invoke-interface/range {p1 .. p1}, Lfi/iki/elonen/NanoHTTPD$IHTTPSession;->getUri()Ljava/lang/String;

    move-result-object v5

    .line 21
    .local v5, "uri":Ljava/lang/String;
    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-object/from16 v6, p1

    :try_start_1
    invoke-interface {v6, v0}, Lfi/iki/elonen/NanoHTTPD$IHTTPSession;->parseBody(Ljava/util/Map;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    move-object/from16 v6, p1

    .line 23
    :goto_0
    invoke-interface/range {p1 .. p1}, Lfi/iki/elonen/NanoHTTPD$IHTTPSession;->getParms()Ljava/util/Map;

    move-result-object v7
    iget-object v0, v1, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;
    invoke-static {v0, v5, v7}, Lcom/pyscript/manager/ApiControl;->safeRequest(Landroid/content/Context;Ljava/lang/String;Ljava/util/Map;)Z
    move-result v0
    if-nez v0, :safe_request
    sget-object v0, Lfi/iki/elonen/NanoHTTPD$Response$Status;->FORBIDDEN:Lfi/iki/elonen/NanoHTTPD$Response$Status;
    const-string v8, "{\"error\":\"invalid script path or filename\"}"
    invoke-direct {v1, v0, v8}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;
    move-result-object v0
    return-object v0
    :safe_request

    .line 24
    .local v7, "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v0, v1, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const-string v8, "ApiPrefs"

    const/4 v9, 0x0

    invoke-virtual {v0, v8, v9}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v8

    .line 25
    .local v8, "apiPrefs":Landroid/content/SharedPreferences;
    const/4 v0, 0x0

    const-string v10, "api_key"

    invoke-interface {v8, v10, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 27
    .local v11, "currentApiKey":Ljava/lang/String;
    move-object v12, v11

    .line 28
    .local v12, "key":Ljava/lang/String;
    if-eqz v12, :cond_26

    invoke-virtual {v12, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    move-object v4, v1

    move-object/from16 v20, v8

    move-object/from16 v17, v11

    move-object/from16 v19, v12

    goto/16 :goto_13

    .line 31
    :cond_0
    :try_start_2
    const-string v0, "/api/scripts"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_11

    const-string v13, "\\\""

    const-string v14, "\""

    const-string v15, "_base"

    const-string v9, "UptimeData"

    if-eqz v0, :cond_a

    .line 32
    :try_start_3
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "["

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 33
    .local v0, "json":Ljava/lang/StringBuilder;
    iget-object v2, v1, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    invoke-virtual {v2}, Lcom/pyscript/manager/DBHelper;->getAllScripts()Ljava/util/List;

    move-result-object v2

    .line 34
    .local v2, "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    iget-object v3, v1, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const/4 v10, 0x0

    invoke-virtual {v3, v9, v10}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 36
    .local v3, "uptimePrefs":Landroid/content/SharedPreferences;
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_1
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v10
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_d

    if-ge v9, v10, :cond_9

    .line 37
    :try_start_4
    invoke-interface {v2, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/pyscript/manager/ScriptModel;

    .line 38
    .local v10, "m":Lcom/pyscript/manager/ScriptModel;
    sget-object v6, Lcom/pyscript/manager/StatsManager;->isRunning:Ljava/util/concurrent/ConcurrentHashMap;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_a

    move-object/from16 v17, v11

    .end local v11    # "currentApiKey":Ljava/lang/String;
    .local v17, "currentApiKey":Ljava/lang/String;
    :try_start_5
    iget-object v11, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v6, v11}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v6
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_9

    if-eqz v6, :cond_1

    :try_start_6
    sget-object v6, Lcom/pyscript/manager/StatsManager;->isRunning:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v11, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v6, v11}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Boolean;

    invoke-virtual {v6}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v6
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2

    if-eqz v6, :cond_1

    const/4 v6, 0x1

    goto :goto_2

    .line 130
    .end local v0    # "json":Ljava/lang/StringBuilder;
    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .end local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .end local v9    # "i":I
    .end local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    :catch_2
    move-exception v0

    move-object/from16 v20, v8

    move-object/from16 v19, v12

    move-object v8, v4

    move-object v4, v1

    goto/16 :goto_12

    .line 38
    .restart local v0    # "json":Ljava/lang/StringBuilder;
    .restart local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .restart local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .restart local v9    # "i":I
    .restart local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    :cond_1
    const/4 v6, 0x0

    .line 39
    .local v6, "isRunning":Z
    :goto_2
    :try_start_7
    sget-object v11, Lcom/pyscript/manager/StatsManager;->cpuMap:Ljava/util/concurrent/ConcurrentHashMap;
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_9

    move-object/from16 v19, v12

    .end local v12    # "key":Ljava/lang/String;
    .local v19, "key":Ljava/lang/String;
    :try_start_8
    iget-object v12, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v11
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_8

    if-eqz v11, :cond_2

    :try_start_9
    sget-object v11, Lcom/pyscript/manager/StatsManager;->cpuMap:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v12, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3

    goto :goto_3

    .line 130
    .end local v0    # "json":Ljava/lang/StringBuilder;
    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .end local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .end local v6    # "isRunning":Z
    .end local v9    # "i":I
    .end local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    :catch_3
    move-exception v0

    move-object/from16 v20, v8

    move-object v8, v4

    move-object v4, v1

    goto/16 :goto_12

    .line 39
    .restart local v0    # "json":Ljava/lang/StringBuilder;
    .restart local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .restart local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .restart local v6    # "isRunning":Z
    .restart local v9    # "i":I
    .restart local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    :cond_2
    :try_start_a
    const-string v11, "0.0%"

    .line 40
    .local v11, "cpu":Ljava/lang/String;
    :goto_3
    sget-object v12, Lcom/pyscript/manager/StatsManager;->ramMap:Ljava/util/concurrent/ConcurrentHashMap;
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_8

    move-object/from16 v20, v8

    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .local v20, "apiPrefs":Landroid/content/SharedPreferences;
    :try_start_b
    iget-object v8, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v12, v8}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v8
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_7

    if-eqz v8, :cond_3

    :try_start_c
    sget-object v8, Lcom/pyscript/manager/StatsManager;->ramMap:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v12, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v8, v12}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_4

    goto :goto_4

    .line 130
    .end local v0    # "json":Ljava/lang/StringBuilder;
    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .end local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .end local v6    # "isRunning":Z
    .end local v9    # "i":I
    .end local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    .end local v11    # "cpu":Ljava/lang/String;
    :catch_4
    move-exception v0

    move-object v8, v4

    move-object v4, v1

    goto/16 :goto_12

    .line 40
    .restart local v0    # "json":Ljava/lang/StringBuilder;
    .restart local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .restart local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .restart local v6    # "isRunning":Z
    .restart local v9    # "i":I
    .restart local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    .restart local v11    # "cpu":Ljava/lang/String;
    :cond_3
    :try_start_d
    const-string v8, "0 MB"

    .line 42
    .local v8, "ram":Ljava/lang/String;
    :goto_4
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_7

    move-object/from16 v21, v4

    :try_start_e
    iget-object v4, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v12, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object v12, v2

    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .local v12, "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    const-wide/16 v1, 0x0

    invoke-interface {v3, v4, v1, v2}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v22
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_6

    .line 43
    .local v22, "baseTime":J
    const-wide/16 v24, 0x0

    .line 44
    .local v24, "sessionTime":J
    if-eqz v6, :cond_4

    :try_start_f
    sget-object v4, Lcom/pyscript/manager/StatsManager;->startTimeMap:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v1, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 45
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sget-object v4, Lcom/pyscript/manager/StatsManager;->startTimeMap:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v28, v3

    .end local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .local v28, "uptimePrefs":Landroid/content/SharedPreferences;
    iget-object v3, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v4, v3}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Long;

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v3
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_5

    sub-long v24, v1, v3

    goto :goto_5

    .line 130
    .end local v0    # "json":Ljava/lang/StringBuilder;
    .end local v6    # "isRunning":Z
    .end local v8    # "ram":Ljava/lang/String;
    .end local v9    # "i":I
    .end local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    .end local v11    # "cpu":Ljava/lang/String;
    .end local v12    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .end local v22    # "baseTime":J
    .end local v24    # "sessionTime":J
    .end local v28    # "uptimePrefs":Landroid/content/SharedPreferences;
    :catch_5
    move-exception v0

    move-object/from16 v4, p0

    goto/16 :goto_11

    .line 44
    .restart local v0    # "json":Ljava/lang/StringBuilder;
    .restart local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .restart local v6    # "isRunning":Z
    .restart local v8    # "ram":Ljava/lang/String;
    .restart local v9    # "i":I
    .restart local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    .restart local v11    # "cpu":Ljava/lang/String;
    .restart local v12    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .restart local v22    # "baseTime":J
    .restart local v24    # "sessionTime":J
    :cond_4
    move-object/from16 v28, v3

    .line 47
    .end local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .restart local v28    # "uptimePrefs":Landroid/content/SharedPreferences;
    :goto_5
    add-long v1, v22, v24

    const-wide/16 v3, 0x3e8

    :try_start_10
    div-long/2addr v1, v3

    .line 48
    .local v1, "tSecs":J
    const-wide/32 v3, 0x1e13380

    div-long v29, v1, v3

    move-wide/from16 v31, v29

    .local v31, "y":J
    rem-long v3, v1, v3

    const-wide/32 v29, 0x278d00

    div-long v3, v3, v29

    .local v3, "mo":J
    rem-long v29, v1, v29

    const-wide/32 v33, 0x15180

    div-long v29, v29, v33

    move-wide/from16 v35, v29

    .line 49
    .local v35, "d":J
    rem-long v29, v1, v33

    const-wide/16 v33, 0xe10

    div-long v29, v29, v33

    .local v29, "h":J
    rem-long v33, v1, v33

    const-wide/16 v37, 0x3c

    div-long v33, v33, v37

    .local v33, "min":J
    rem-long v37, v1, v37

    .line 51
    .local v37, "s":J
    new-instance v39, Ljava/lang/StringBuilder;

    invoke-direct/range {v39 .. v39}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_6

    move-object/from16 v40, v39

    .line 52
    .local v40, "upSb":Ljava/lang/StringBuilder;
    move-wide/from16 v41, v1

    move-wide/from16 v1, v31

    const-wide/16 v26, 0x0

    .end local v31    # "y":J
    .local v1, "y":J
    .local v41, "tSecs":J
    cmp-long v31, v1, v26

    if-lez v31, :cond_5

    move-object/from16 v32, v7

    move-object/from16 v31, v15

    move-object/from16 v15, v40

    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v40    # "upSb":Ljava/lang/StringBuilder;
    .local v15, "upSb":Ljava/lang/StringBuilder;
    .local v32, "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_11
    invoke-virtual {v15, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    move-wide/from16 v39, v1

    .end local v1    # "y":J
    .local v39, "y":J
    const-string v1, "Y "

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_6

    .end local v15    # "upSb":Ljava/lang/StringBuilder;
    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v39    # "y":J
    .restart local v1    # "y":J
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v40    # "upSb":Ljava/lang/StringBuilder;
    :cond_5
    move-object/from16 v32, v7

    move-object/from16 v31, v15

    move-object/from16 v15, v40

    move-wide/from16 v39, v1

    .end local v1    # "y":J
    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v40    # "upSb":Ljava/lang/StringBuilder;
    .restart local v15    # "upSb":Ljava/lang/StringBuilder;
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v39    # "y":J
    :goto_6
    const-wide/16 v1, 0x0

    cmp-long v7, v3, v1

    if-lez v7, :cond_6

    invoke-virtual {v15, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "M "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_6
    move-wide/from16 v1, v35

    const-wide/16 v26, 0x0

    .end local v35    # "d":J
    .local v1, "d":J
    cmp-long v7, v1, v26

    if-lez v7, :cond_7

    invoke-virtual {v15, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    move-wide/from16 v26, v1

    .end local v1    # "d":J
    .local v26, "d":J
    const-string v1, "d "

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_7

    .end local v26    # "d":J
    .restart local v1    # "d":J
    :cond_7
    move-wide/from16 v26, v1

    .line 53
    .end local v1    # "d":J
    .restart local v26    # "d":J
    :goto_7
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v2, "%02d:%02d:%02d"

    const/4 v7, 0x3

    move-wide/from16 v35, v3

    .end local v3    # "mo":J
    .local v35, "mo":J
    new-array v3, v7, [Ljava/lang/Object;

    invoke-static/range {v29 .. v30}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const/16 v16, 0x0

    aput-object v4, v3, v16

    invoke-static/range {v33 .. v34}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const/16 v18, 0x1

    aput-object v4, v3, v18

    invoke-static/range {v37 .. v38}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const/16 v43, 0x2

    aput-object v4, v3, v43

    invoke-static {v1, v2, v3}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 55
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v2, "{\"id\":%d, \"name\":\"%s\", \"path\":\"%s\", \"is_running\":%b, \"cpu\":\"%s\", \"ram\":\"%s\", \"uptime\":\"%s\"}"

    const/4 v3, 0x7

    new-array v3, v3, [Ljava/lang/Object;

    iget v4, v10, Lcom/pyscript/manager/ScriptModel;->id:I

    .line 56
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/16 v16, 0x0

    aput-object v4, v3, v16

    iget-object v4, v10, Lcom/pyscript/manager/ScriptModel;->name:Ljava/lang/String;

    invoke-virtual {v4, v14, v13}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    const/16 v18, 0x1

    aput-object v4, v3, v18

    iget-object v4, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v4, v14, v13}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v43

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    aput-object v4, v3, v7

    const/4 v4, 0x4

    aput-object v11, v3, v4

    const/4 v4, 0x5

    aput-object v8, v3, v4

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v7, 0x6

    aput-object v4, v3, v7

    .line 55
    invoke-static {v1, v2, v3}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 57
    invoke-interface {v12}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    if-ge v9, v1, :cond_8

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 36
    .end local v6    # "isRunning":Z
    .end local v8    # "ram":Ljava/lang/String;
    .end local v10    # "m":Lcom/pyscript/manager/ScriptModel;
    .end local v11    # "cpu":Ljava/lang/String;
    .end local v15    # "upSb":Ljava/lang/StringBuilder;
    .end local v22    # "baseTime":J
    .end local v24    # "sessionTime":J
    .end local v26    # "d":J
    .end local v29    # "h":J
    .end local v33    # "min":J
    .end local v35    # "mo":J
    .end local v37    # "s":J
    .end local v39    # "y":J
    .end local v41    # "tSecs":J
    :cond_8
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v1, p0

    move-object/from16 v6, p1

    move-object v2, v12

    move-object/from16 v11, v17

    move-object/from16 v12, v19

    move-object/from16 v8, v20

    move-object/from16 v4, v21

    move-object/from16 v3, v28

    move-object/from16 v15, v31

    move-object/from16 v7, v32

    goto/16 :goto_1

    .line 130
    .end local v0    # "json":Ljava/lang/StringBuilder;
    .end local v9    # "i":I
    .end local v12    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .end local v28    # "uptimePrefs":Landroid/content/SharedPreferences;
    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_6
    move-exception v0

    move-object/from16 v4, p0

    move-object/from16 v8, v21

    goto :goto_8

    :catch_7
    move-exception v0

    move-object v8, v4

    move-object/from16 v4, p0

    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :goto_8
    goto/16 :goto_12

    .end local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local v8, "apiPrefs":Landroid/content/SharedPreferences;
    :catch_8
    move-exception v0

    move-object/from16 v20, v8

    move-object v8, v4

    move-object/from16 v4, p0

    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    goto/16 :goto_12

    .end local v19    # "key":Ljava/lang/String;
    .end local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .local v12, "key":Ljava/lang/String;
    :catch_9
    move-exception v0

    move-object/from16 v20, v8

    move-object/from16 v19, v12

    move-object v8, v4

    move-object/from16 v4, p0

    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v12    # "key":Ljava/lang/String;
    .restart local v19    # "key":Ljava/lang/String;
    .restart local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    goto/16 :goto_12

    .end local v17    # "currentApiKey":Ljava/lang/String;
    .end local v19    # "key":Ljava/lang/String;
    .end local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .local v11, "currentApiKey":Ljava/lang/String;
    .restart local v12    # "key":Ljava/lang/String;
    :catch_a
    move-exception v0

    move-object/from16 v20, v8

    move-object/from16 v17, v11

    move-object/from16 v19, v12

    move-object v8, v4

    move-object/from16 v4, p0

    goto :goto_a

    .line 36
    .restart local v0    # "json":Ljava/lang/StringBuilder;
    .restart local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .local v3, "uptimePrefs":Landroid/content/SharedPreferences;
    .restart local v9    # "i":I
    :cond_9
    move-object/from16 v28, v3

    move-object/from16 v21, v4

    move-object/from16 v32, v7

    move-object/from16 v20, v8

    move-object/from16 v17, v11

    move-object/from16 v19, v12

    move-object v12, v2

    .line 59
    .end local v2    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .end local v3    # "uptimePrefs":Landroid/content/SharedPreferences;
    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v9    # "i":I
    .end local v11    # "currentApiKey":Ljava/lang/String;
    .local v12, "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .restart local v17    # "currentApiKey":Ljava/lang/String;
    .restart local v19    # "key":Ljava/lang/String;
    .restart local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v28    # "uptimePrefs":Landroid/content/SharedPreferences;
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v2, "]"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_c

    move-object/from16 v4, p0

    :try_start_12
    invoke-direct {v4, v1, v2}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_b

    return-object v1

    .line 130
    .end local v0    # "json":Ljava/lang/StringBuilder;
    .end local v12    # "list":Ljava/util/List;, "Ljava/util/List<Lcom/pyscript/manager/ScriptModel;>;"
    .end local v28    # "uptimePrefs":Landroid/content/SharedPreferences;
    :catch_b
    move-exception v0

    goto :goto_9

    :catch_c
    move-exception v0

    move-object/from16 v4, p0

    :goto_9
    move-object/from16 v8, v21

    move-object/from16 v7, v32

    goto/16 :goto_12

    .end local v17    # "currentApiKey":Ljava/lang/String;
    .end local v19    # "key":Ljava/lang/String;
    .end local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v11    # "currentApiKey":Ljava/lang/String;
    .local v12, "key":Ljava/lang/String;
    :catch_d
    move-exception v0

    move-object/from16 v21, v4

    move-object/from16 v20, v8

    move-object/from16 v17, v11

    move-object/from16 v19, v12

    move-object v4, v1

    move-object/from16 v8, v21

    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v11    # "currentApiKey":Ljava/lang/String;
    .end local v12    # "key":Ljava/lang/String;
    .restart local v17    # "currentApiKey":Ljava/lang/String;
    .restart local v19    # "key":Ljava/lang/String;
    .restart local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :goto_a
    goto/16 :goto_12

    .line 61
    .end local v17    # "currentApiKey":Ljava/lang/String;
    .end local v19    # "key":Ljava/lang/String;
    .end local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v11    # "currentApiKey":Ljava/lang/String;
    .restart local v12    # "key":Ljava/lang/String;
    :cond_a
    move-object/from16 v21, v4

    move-object/from16 v32, v7

    move-object/from16 v20, v8

    move-object/from16 v17, v11

    move-object/from16 v19, v12

    move-object/from16 v31, v15

    move-object v4, v1

    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v11    # "currentApiKey":Ljava/lang/String;
    .end local v12    # "key":Ljava/lang/String;
    .restart local v17    # "currentApiKey":Ljava/lang/String;
    .restart local v19    # "key":Ljava/lang/String;
    .restart local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_13
    const-string v0, "/api/run"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_10

    const-string v1, "action"

    const-string v6, "path"

    if-eqz v0, :cond_c

    .line 62
    move-object/from16 v7, v32

    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_14
    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 63
    .local v0, "path":Ljava/lang/String;
    if-eqz v0, :cond_b

    iget-object v2, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    new-instance v3, Landroid/content/Intent;

    iget-object v8, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const-class v9, Lcom/pyscript/manager/ScriptService;

    invoke-direct {v3, v8, v9}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v8, "run"

    invoke-virtual {v3, v1, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1, v6, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    iget-object v1, v4, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    const-string v2, "RUNNING"

    invoke-virtual {v1, v0, v2}, Lcom/pyscript/manager/DBHelper;->updateStatusByPath(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v2, "{\"status\":\"started\"}"

    invoke-direct {v4, v1, v2}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1

    return-object v1

    .line 64
    .end local v0    # "path":Ljava/lang/String;
    :cond_b
    goto/16 :goto_10

    .line 65
    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_c
    move-object/from16 v7, v32

    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v0, "/api/stop"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_f

    const-string v8, "stop"

    if-eqz v0, :cond_e

    .line 66
    :try_start_15
    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 67
    .restart local v0    # "path":Ljava/lang/String;
    if-eqz v0, :cond_d

    iget-object v2, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    new-instance v3, Landroid/content/Intent;

    iget-object v9, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const-class v10, Lcom/pyscript/manager/ScriptService;

    invoke-direct {v3, v9, v10}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v3, v1, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1, v6, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    iget-object v1, v4, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    const-string v2, "STOPPED"

    invoke-virtual {v1, v0, v2}, Lcom/pyscript/manager/DBHelper;->updateStatusByPath(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v2, "{\"status\":\"stopped\"}"

    invoke-direct {v4, v1, v2}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1

    return-object v1

    .line 68
    .end local v0    # "path":Ljava/lang/String;
    :cond_d
    goto/16 :goto_10

    .line 69
    :cond_e
    const-string v0, "/api/rst"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    .line 70
    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 71
    .restart local v0    # "path":Ljava/lang/String;
    if-eqz v0, :cond_10

    .line 72
    iget-object v1, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const/4 v2, 0x0

    invoke-virtual {v1, v9, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v11, v31

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 73
    sget-object v1, Lcom/pyscript/manager/StatsManager;->isRunning:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_f

    sget-object v1, Lcom/pyscript/manager/StatsManager;->isRunning:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_f

    sget-object v1, Lcom/pyscript/manager/StatsManager;->startTimeMap:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 74
    :cond_f
    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v2, "{\"status\":\"reset_success\"}"

    invoke-direct {v4, v1, v2}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1

    return-object v1

    .line 76
    .end local v0    # "path":Ljava/lang/String;
    :cond_10
    goto/16 :goto_10

    .line 77
    :cond_11
    move-object/from16 v11, v31

    const-string v0, "/api/delete"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_16

    .line 78
    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 79
    .restart local v0    # "path":Ljava/lang/String;
    if-eqz v0, :cond_15

    .line 80
    sget-object v2, Lcom/pyscript/manager/StatsManager;->isRunning:Ljava/util/concurrent/ConcurrentHashMap;

    const/4 v3, 0x0

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    invoke-virtual {v2, v0, v10}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 81
    iget-object v2, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    new-instance v3, Landroid/content/Intent;

    iget-object v10, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const-class v12, Lcom/pyscript/manager/ScriptService;

    invoke-direct {v3, v10, v12}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v3, v1, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1, v6, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 82
    iget-object v1, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const/4 v2, 0x0

    invoke-virtual {v1, v9, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 83
    iget-object v1, v4, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    invoke-virtual {v1}, Lcom/pyscript/manager/DBHelper;->getAllScripts()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_b
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_13

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/pyscript/manager/ScriptModel;

    .local v2, "sm":Lcom/pyscript/manager/ScriptModel;
    iget-object v3, v2, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_12

    iget-object v1, v4, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    iget v3, v2, Lcom/pyscript/manager/ScriptModel;->id:I

    invoke-virtual {v1, v3}, Lcom/pyscript/manager/DBHelper;->deleteScript(I)V

    goto :goto_c

    .end local v2    # "sm":Lcom/pyscript/manager/ScriptModel;
    :cond_12
    goto :goto_b

    .line 84
    :cond_13
    :goto_c
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v1, "f":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_14

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 85
    :cond_14
    sget-object v2, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v3, "{\"status\":\"deleted\"}"

    invoke-direct {v4, v2, v3}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v2

    return-object v2

    .line 87
    .end local v0    # "path":Ljava/lang/String;
    .end local v1    # "f":Ljava/io/File;
    :cond_15
    goto/16 :goto_10

    .line 88
    :cond_16
    const-string v0, "/api/terminal_output"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_19

    .line 89
    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 90
    .restart local v0    # "path":Ljava/lang/String;
    if-eqz v0, :cond_18

    .line 91
    sget-object v1, Lcom/pyscript/manager/LogManager;->scriptLogs:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/StringBuilder;

    .line 92
    .local v1, "logs":Ljava/lang/StringBuilder;
    if-eqz v1, :cond_17

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_d

    :cond_17
    const-string v2, "System Initializing... no logs yet."

    .line 93
    .local v2, "finalLogs":Ljava/lang/String;
    :goto_d
    const-string v3, "\\"

    const-string v6, "\\\\"

    invoke-virtual {v2, v3, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v14, v13}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    const-string v6, "\n"

    const-string v8, "\\n"

    invoke-virtual {v3, v6, v8}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    const-string v6, "\r"

    const-string v8, ""

    invoke-virtual {v3, v6, v8}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v3

    move-object v2, v3

    .line 94
    sget-object v3, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "{\"logs\":\""

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_f

    move-object/from16 v8, v21

    :try_start_16
    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v3, v6}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v3

    return-object v3

    .line 96
    .end local v0    # "path":Ljava/lang/String;
    .end local v1    # "logs":Ljava/lang/StringBuilder;
    .end local v2    # "finalLogs":Ljava/lang/String;
    :cond_18
    goto/16 :goto_10

    .line 97
    :cond_19
    move-object/from16 v8, v21

    const-string v0, "/api/change_key"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1b

    .line 98
    const-string v0, "new_key"

    invoke-interface {v7, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 99
    .local v0, "newKey":Ljava/lang/String;
    if-eqz v0, :cond_1a

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1a

    .line 100
    invoke-interface/range {v20 .. v20}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v10, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 101
    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v2, "{\"status\":\"key_updated\"}"

    invoke-direct {v4, v1, v2}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1

    return-object v1

    .line 103
    .end local v0    # "newKey":Ljava/lang/String;
    :cond_1a
    goto/16 :goto_10

    .line 104
    :cond_1b
    const-string v0, "/api/terminal"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1d

    .line 105
    invoke-interface {v7, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 106
    .local v0, "cmd":Ljava/lang/String;
    if-eqz v0, :cond_1c

    iget-object v2, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    new-instance v6, Landroid/content/Intent;

    iget-object v9, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const-class v10, Lcom/pyscript/manager/ScriptService;

    invoke-direct {v6, v9, v10}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v9, "terminal_cmd"

    invoke-virtual {v6, v1, v9}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1, v3, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v2, "{\"status\":\"executed\"}"

    invoke-direct {v4, v1, v2}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1

    return-object v1

    .line 107
    .end local v0    # "cmd":Ljava/lang/String;
    :cond_1c
    goto/16 :goto_10

    .line 108
    :cond_1d
    const-string v0, "/api/upload"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_e

    const-string v1, "UTF-8"

    if-eqz v0, :cond_23

    :try_start_17
    sget-object v0, Lfi/iki/elonen/NanoHTTPD$Method;->POST:Lfi/iki/elonen/NanoHTTPD$Method;

    invoke-interface/range {p1 .. p1}, Lfi/iki/elonen/NanoHTTPD$IHTTPSession;->getMethod()Lfi/iki/elonen/NanoHTTPD$Method;

    move-result-object v3

    invoke-virtual {v0, v3}, Lfi/iki/elonen/NanoHTTPD$Method;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_23

    .line 109
    const-string v0, "code"

    invoke-interface {v7, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .local v0, "code":Ljava/lang/String;
    const-string v3, "filename"

    invoke-interface {v7, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 110
    .local v3, "filename":Ljava/lang/String;
    if-eqz v3, :cond_22

    if-eqz v0, :cond_22

    .line 111
    invoke-virtual {v3, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_1e

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .line 112
    :cond_1e
    new-instance v2, Ljava/io/File;

    iget-object v6, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    const/4 v9, 0x0

    invoke-virtual {v6, v9}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v6

    invoke-direct {v2, v6, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 113
    .local v2, "file":Ljava/io/File;
    new-instance v6, Ljava/io/FileOutputStream;

    invoke-direct {v6, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .local v6, "fos":Ljava/io/FileOutputStream;
    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v6, v1}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V

    .line 114
    const/4 v1, 0x0

    .local v1, "exists":Z
    iget-object v9, v4, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    invoke-virtual {v9}, Lcom/pyscript/manager/DBHelper;->getAllScripts()Ljava/util/List;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    :goto_e
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_20

    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lcom/pyscript/manager/ScriptModel;

    .local v10, "s":Lcom/pyscript/manager/ScriptModel;
    iget-object v11, v10, Lcom/pyscript/manager/ScriptModel;->path:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_1f

    const/4 v1, 0x1

    goto :goto_f

    .end local v10    # "s":Lcom/pyscript/manager/ScriptModel;
    :cond_1f
    goto :goto_e

    .line 115
    :cond_20
    :goto_f
    if-nez v1, :cond_21

    iget-object v9, v4, Lcom/pyscript/manager/ApiServer;->db:Lcom/pyscript/manager/DBHelper;

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v3, v10}, Lcom/pyscript/manager/DBHelper;->addScript(Ljava/lang/String;Ljava/lang/String;)V

    .line 116
    :cond_21
    sget-object v9, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v10, "{\"status\":\"uploaded\"}"

    invoke-direct {v4, v9, v10}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v8

    return-object v8

    .line 118
    .end local v0    # "code":Ljava/lang/String;
    .end local v1    # "exists":Z
    .end local v2    # "file":Ljava/io/File;
    .end local v3    # "filename":Ljava/lang/String;
    .end local v6    # "fos":Ljava/io/FileOutputStream;
    :cond_22
    goto :goto_10

    .line 120
    :cond_23
    const-string v0, "/api/upload_proxies"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_25

    sget-object v0, Lfi/iki/elonen/NanoHTTPD$Method;->POST:Lfi/iki/elonen/NanoHTTPD$Method;

    invoke-interface/range {p1 .. p1}, Lfi/iki/elonen/NanoHTTPD$IHTTPSession;->getMethod()Lfi/iki/elonen/NanoHTTPD$Method;

    move-result-object v2

    invoke-virtual {v0, v2}, Lfi/iki/elonen/NanoHTTPD$Method;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_25

    .line 121
    const-string v0, "proxies"

    invoke-interface {v7, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 122
    .local v0, "proxies":Ljava/lang/String;
    if-eqz v0, :cond_25

    .line 123
    new-instance v2, Ljava/io/File;

    iget-object v3, v4, Lcom/pyscript/manager/ApiServer;->ctx:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v3

    const-string v6, "pylibs"

    invoke-direct {v2, v3, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .local v2, "libsDir":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_24

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 124
    :cond_24
    new-instance v3, Ljava/io/File;

    const-string v6, "proxies.txt"

    invoke-direct {v3, v2, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 125
    .local v3, "file":Ljava/io/File;
    new-instance v6, Ljava/io/FileOutputStream;

    invoke-direct {v6, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .restart local v6    # "fos":Ljava/io/FileOutputStream;
    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v6, v1}, Ljava/io/FileOutputStream;->write([B)V

    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V

    .line 126
    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->OK:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v9, "{\"status\":\"proxies_uploaded\"}"

    invoke-direct {v4, v1, v9}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_e

    return-object v1

    .line 130
    .end local v0    # "proxies":Ljava/lang/String;
    .end local v2    # "libsDir":Ljava/io/File;
    .end local v3    # "file":Ljava/io/File;
    .end local v6    # "fos":Ljava/io/FileOutputStream;
    :cond_25
    :goto_10
    nop

    .line 131
    sget-object v0, Lfi/iki/elonen/NanoHTTPD$Response$Status;->NOT_FOUND:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v1, "{\"error\": \"Endpoint not found.\"}"

    invoke-direct {v4, v0, v1}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v0

    return-object v0

    .line 130
    :catch_e
    move-exception v0

    goto :goto_12

    :catch_f
    move-exception v0

    :goto_11
    move-object/from16 v8, v21

    goto :goto_12

    .end local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_10
    move-exception v0

    move-object/from16 v8, v21

    move-object/from16 v7, v32

    .end local v32    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v7    # "parms":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    goto :goto_12

    .end local v17    # "currentApiKey":Ljava/lang/String;
    .end local v19    # "key":Ljava/lang/String;
    .end local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v11    # "currentApiKey":Ljava/lang/String;
    .restart local v12    # "key":Ljava/lang/String;
    :catch_11
    move-exception v0

    move-object/from16 v20, v8

    move-object/from16 v17, v11

    move-object/from16 v19, v12

    move-object v8, v4

    move-object v4, v1

    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v11    # "currentApiKey":Ljava/lang/String;
    .end local v12    # "key":Ljava/lang/String;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v17    # "currentApiKey":Ljava/lang/String;
    .restart local v19    # "key":Ljava/lang/String;
    .restart local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    :goto_12
    sget-object v1, Lfi/iki/elonen/NanoHTTPD$Response$Status;->INTERNAL_ERROR:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "{\"error\":\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v4, v1, v2}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v1

    return-object v1

    .line 28
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v17    # "currentApiKey":Ljava/lang/String;
    .end local v19    # "key":Ljava/lang/String;
    .end local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .restart local v11    # "currentApiKey":Ljava/lang/String;
    .restart local v12    # "key":Ljava/lang/String;
    :cond_26
    move-object v4, v1

    move-object/from16 v20, v8

    move-object/from16 v17, v11

    move-object/from16 v19, v12

    .end local v8    # "apiPrefs":Landroid/content/SharedPreferences;
    .end local v11    # "currentApiKey":Ljava/lang/String;
    .end local v12    # "key":Ljava/lang/String;
    .restart local v17    # "currentApiKey":Ljava/lang/String;
    .restart local v19    # "key":Ljava/lang/String;
    .restart local v20    # "apiPrefs":Landroid/content/SharedPreferences;
    :goto_13
    sget-object v0, Lfi/iki/elonen/NanoHTTPD$Response$Status;->UNAUTHORIZED:Lfi/iki/elonen/NanoHTTPD$Response$Status;

    const-string v1, "{\"error\": \"Unauthorized.\"}"

    invoke-direct {v4, v0, v1}, Lcom/pyscript/manager/ApiServer;->createResponse(Lfi/iki/elonen/NanoHTTPD$Response$Status;Ljava/lang/String;)Lfi/iki/elonen/NanoHTTPD$Response;

    move-result-object v0

    return-object v0
.end method
