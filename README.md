# QuantMonitor.net Open source Monitoring Agent, now needs rewrite for free 3rd party monitoring services like https://cronitor.io/ or other alternatives.

Complete manual how it works and how to use: https://github.com/quantmonitornet/Tradestation-Agent/blob/main/QuantMonitor%20agent%20guide.pdf

# Description of the Tradestation monitoring agent 

TradeStation agent
In this chapter, we will activate QuantMonitoring agent in the TradeStation trading platform. From our experience, smooth running of Trading Robots in this platform might be quite challenging compared to MT4 or MT5. Therefore, using monitoring tools in these platforms is even more important than in other ones.

I will describe the installation in two ways. The first is intended for experienced traders. In the second way, I will describe the installation step by step.


 
Install the agent and insert “Name” and “License” values. On the image you can find TradeStation agent. In this manual, you can find chapters where we step-by-step show platform Agent installation process.


Brief description of the monitoring agent installation.

1.	Unzip downloaded file
2.	There is a folder called “Program” which contains three DLL files. These files enable connection of the agent to the monitoring server via HTTP requests. You need to copy them into folder where TradeStation DLL files are stored :C:\Program Files (x86)\TradeStation 9.5\Program 
3.	After copying the files, let’s start TradeStation program. (If you are already running it then you need to restart it before activating the agent)
4.	Monitoring agent is basically TradeStation strategy. The file name is: QUANTMONITORTRADESTATIONAGENT.ELD
5.	Let’s import the file into TradeStation. After importing new strategy with name “Agent” will appear
6.	Create new Chart analysis. Change it’s timeframe to tick and symbol to @ES or any other symbol which is being traded most of the time.
7.	Insert “Agent” strategy into the chart.
8.	Update strategy inputs “VPSname” and “License” using values described in the chapter “Registering new monitoring agent”.
9.	After confirming the inputs, please wait until monitoring dashboard recognize the agent. This might take several minutes.
 

Now let’s copy Program folder and paste it into C:\Program Files (x86)\TradeStation 9.5\Program folder (The TradeStation installation folder might have a different path). After this step you can start TradeStation program.

 
In the main menu click File -> Import/Export easlanguage and in the appearing popup window choose “Import EasyLanguage file” option. Click “Next”.

 
In the next step select file QuantMonitorTradeStationAgent.eld, open it and confirm import into TradeStation.

 
Our agent will run as a strategy in the chart window. Therefore open the new chart analysis.

 
After adding new chart, you need to change its timeframe to ‘Tick” and symbol to “@ES” or similar symbol which is being traded most of the time. Right click on the appeared Chart analysis and select “Symbol option”)

 
Again right click on the Analysis window and select option “Insert Strategy”. In the appearing dialog select strategy called “Agent”


After adding monitoring agent strategy you need to connect it to the QuantMonitoring dashboard. Click “Format” button

 
You need to define “VPSName” and “License” inputs. We are discussing these values in detail in chapter “Registering new monitoring agent”. After updating values let’s confirm the dialog. 

 
Troubleshooting
Problem with the agent connection
It might happen that the agent cannot connect to the dashboard. In this case just delete agent from the ChartAnalysis and insert it again. You can also try to just edit “License” input (by adding some litere and deleting it, so TradeStation recognize changes). 

States that the agent is able to detect
1.	Monitoring Dashboard will notify you in case that in TradeStation trading is disabled but data are still running.
2.	Monitoring Dashboard will notify you if it will lost connection with the Agent. This might happen because TradeStation is offline or VPS is offline.
MultiCharts agent
Brief description of the monitoring agent installation.

1.	Unzip downloaded file
2.	There archive contains three dll files. These files enables connection of the agent to the monitoring server via http requests. You need to copy them into folder where MultiCharts dll files are stored : C:\Program Files\TS Support\MultiCharts64 
3.	After copying the files let’s start MultiCharts program. (If you are already running it then you need to restart it before activating the agent)
4.	Monitoring agent is basically MultiCharts signal (strategy). The file name is: QuantMonitorMultiChartsAgent.pla
5.	Let’s open PowerLanguage editor import the file into MultiCharts. After importing new signal with name “Agent” will appear
6.	Create new Chart window. Change it’s timeframe to tick and symbol to @ES or any other symbol which is being traded most of the time.
7.	Insert “Agent” signal into the chart.
8.	Update inputs inputs “VPSname” and “License” using values described in the chapter “Registering new monitoring agent”.
9.	After confirming the inputs please wait until monitoring dashboard recognize the agent. This might takes several minutes.



 
After downloading QuantMonitorTradeStationAgent,zip file let’s extract it.




 
Now let’s copy all dll files and paste it into C:\Program Files\TS Support\MultiCharts64 (The MultiCharts installation folder might have a different path). After this step you can start MultiCharts program.

 
Open new Power language editor window

 
In the main menu click File -> Import and in the appearing menu select QuantMonitorMultiChartsAgent file and continue.

 
In the next step confirm adding QuantMonitorMultiCharts agent.

 
Our agent will run as a signal in the chart window. Therefore open the new chart.

 
The charts need to be connected to the active datafeed.

 
Again right click on the Chart window and select option “Insert Study”.


 
 In the appearing dialog select signal called “QuantMonitorMultiChartsAgent”


 
After adding monitoring agent strategy, you need to connect it to the QuantMonitoring dashboard. Click “Format” button

 
You need to define “VPSName” and “License” inputs. We are discussing these values in detail in chapter “Registering a new monitoring agent”. After updating values, let’s confirm the dialog. 

