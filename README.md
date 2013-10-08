RHEMS LogSystem
=========
RHEMS LogSystemでは基本インフラ向けのlogを収集する為に開発をしました。
サーバでsyslogの設定をするだけでクライアントの設定は完了です。

![alt tag](https://github.com/RHEMS-Japan/LogSystem/blob/master/img/rhems_log.jpg?raw=true)


logの流れ
====================
1. vpcのインスタンスからrsyslogでLOG SENDER01/02に送る
2. LOG SENDER プロセスが1メッセージづつRabbitMQのサーバへ送信します
3. 受け取ったメッセージはSpoolされます
4. Log Serverでは受け取ったqueueをファイルに出力したり直接DBへ流しこむこともできます
5. 6. 7. 古いlogはS3,Glacierに移動しコストを抑えます。

特徴
====================
・syslogの設定をするだけでlogの収集ができます。(switch/loadbalancer,etcでも使えます)
・localのサーバにはlogを吐かないのでディスクの調整をしなくてよくなります。
・awsのインスタンスが消えても大事なlogは保持できます。
・設計上はサーバが数千、数万台になっても構成を変えることなくシステムの拡張ができます。
・サーバが追加される度にconfの設定の必要がない



