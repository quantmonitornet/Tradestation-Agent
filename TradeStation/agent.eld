
using elsystem; 
using elsystem.collections;   
using elsystem.io;  
using tsdata.common; 
using tsdata.marketdata; 
using tsdata.trading;  

external: "QuantMonitorTools32.dll", int, "httpGetA", string;

Inputs:
	VpsName ("tradestation"),
	License ("LICENCE"),
	PositionsCheckDay (5),		//0=Sunday, 1=Monday ... 6=Saturday
	PositionsCheckHour (20),	//24 hour format
	PositionsCheckMinute (30),
	TradedSymbols ("@KC,@ES");			//coma separated list of symbols	

vars:
	ConnectionStatus stat(null),
	elsystem.Timer Timer1(null), 
	ConnectionStatusValue("1"),
	OpenPositionsValue("0"),
	TempStr(""),
	CommaPos(0),
	SymbolIndex(0),
	intrabarpersist test (1),
	intrabarpersist counter(0);	

array: 
	IntraBarPersist SymbolsArray[]("");

Method int Activate()
Begin
	return HttpGetA("https://licenseserver" + License + "?Host="+ VpsName + "&Login=test&Path=test");	
End;

method void sendData(Dictionary msg)
var:
int SizeDict,
Vector Keys,
Vector Vols,
int Ctr;
begin
	SizeDict = msg.Count;
	Keys = msg.Keys;
	Vols = msg.Values;

	for Ctr = 0 to SizeDict - 1 begin
		Print("Request response: ", HttpGetA("https://server.net/send/" + VpsName + "_" + License + "?server=0&key=" + Keys[Ctr].ToString() + "&value=" + Vols[Ctr].ToString())); 
   Print("https://server.net/send/" + VpsName + "_" + License + "?server=0&key=" + Keys[Ctr].ToString() + "&value=" + Vols[Ctr].ToString()); 
    end;
end;


method void Timer1_Elapsed( elsystem.Object sender, elsystem.TimerElapsedEventArgs args ) 
Var:
	Dictionary Dict;
begin

	If counter = 0 then begin
		test = Activate();
		counter = counter+1;
	end;
	Print("Checking connection status...");
	
	if(stat.IsMarketDataConnected() and stat.IsTradingConnected()) then	ConnectionStatusValue = "1" else ConnectionStatusValue = "0";
	
	OpenPositionsValue = "0";
		
	If DayOfWeek(CurrentDate) = PositionsCheckDay and Currenttime >= (PositionsCheckHour * 100 + PositionsCheckMinute) Then begin
		Print("Checking open positions...");
		
		For Value1 = 0 to Array_getmaxindex(SymbolsArray) begin
			Value2 = Getpositionquantity(SymbolsArray[Value1], GetAccountID);
			Print("Symbol: " + SymbolsArray[Value1] + " - Open positions: " + NumToStr(Value2,0));
			
			If Value2 > 0 Then begin 
				OpenPositionsValue = "1";
				break;
			end;	
		end;
	end; 
	
	Dict = New Dictionary;
    Dict.Add("Activity", ConnectionStatusValue);
    Dict.Add("FridayTradeCheck", OpenPositionsValue);
	
	If (test = 200) then sendData(Dict);
	Print(elsystem.datetime.CurrentTime.tostring() + " - ", stat.IsMarketDataConnected(), "/", stat.IsTradingConnected());
	if (counter = 60) then counter = 0;

end;

once begin
	stat = New ConnectionStatus;
	
	//Setup a timer for periodical checks

	Timer1 = new elsystem.Timer; 		// Create a new Timer
	Timer1.Interval = 60 * 1000; 		// Set timer to update every minute
	Timer1.Elapsed += Timer1_Elapsed; 	// Calls the Method subroutine "Timer1_Elapsed" when the timer expires
	Timer1.Enable = true; 				// Start the timer
	
	//Split the TradedSymbols string into array of symbols
	
	TempStr = TradedSymbols;
	CommaPos = InStr(TempStr, ",");
	SymbolIndex = 0;
	
	While CommaPos > 0 begin
		Array_setmaxindex(SymbolsArray, SymbolIndex);
		SymbolsArray[SymbolIndex] = LeftStr(TempStr, CommaPos - 1);
		
		If Strlen(TempStr) > CommaPos Then TempStr = RightStr(TempStr, Strlen(TempStr) - CommaPos);
		
		SymbolIndex = SymbolIndex + 1;
		CommaPos = InStr(TempStr, ",");
	end;
	
	Array_setmaxindex(SymbolsArray, SymbolIndex);
	SymbolsArray[SymbolIndex] = TempStr;
end;

