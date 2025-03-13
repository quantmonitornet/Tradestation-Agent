external: "QuantMonitorTools64.dll", int, "httpGetA", string;


Inputs:
	VpsName ("tradestation"),
	License ("LICENCE"),
	RecalcAfter(15);
	
	
Variables:

	IntraBarPersist PrevATSStatus(0),	// Holds the status of the ATS at the previous update
	IntraBarPersist PrevNumberOfOpenPositions(0),				// Holds the previous MarketPosition
	atsStatus(0), NumberOfOpenPositions(0), test(0), brokerConnectionStatus(1);

// navazani spojeni
Once begin 
test = HttpGetA("https://server.net/api/v1/check/" + License + "?Host="+ VpsName + "&Login=test&Path=test");
if test = 200 then print("Successfuly connected to gateway");
end;


if (LastBarOnChart_s = True) then begin
	atsStatus 	= GetAppInfo(aiStrategyAuto);
	NumberOfOpenPositions= MarketPosition(0) * CurrentContracts;

	

{

	If your broker (IB, ZF, Pats) supports it, 
	you might want to replace the line above with the
	line below. However, keep in mind that: 
	"If Automated Trading was manually turned off by the user, the value returned 
	by the keyword stops changing, and may remain unequal to '0'." (Source: Helpfile) 
	mp = MarketPosition_at_Broker;
}

	


	// ztraceno spojeni
	if (atsStatus <> PrevATSStatus) and (PrevATSStatus = 1) then begin

		if (PrevNumberOfOpenPositions <> 0) then begin		
			// ztraceno spojeni s brokerem, existuji otevrene pozice
			Print(CurrentDate,CurrentTime,"Connection lost, open position exist");
			brokerConnectionStatus = 0;			
		end else begin 		
			Print(CurrentDate,CurrentTime,"Connection lost");
			brokerConnectionStatus = 0;
		end;

			

	end;
	// znovuobnoveni spojeni s brokerem
	if (atsStatus <> PrevATSStatus) and (PrevATSStatus = 0) then begin	
		Print(CurrentDate,CurrentTime,"Connection reestablished");
		brokerConnectionStatus = 1;	
	end;


	PrevATSStatus = atsStatus;
	PrevNumberOfOpenPositions= NumberOfOpenPositions;
 	Print("Current time hearbeat: ", FormatTime("HH:mm:ss", ELTimeToDateTime_s(CurrentTime_s)), ".");
	if test = 200 then 
		begin
		Print("Request response: ", HttpGetA("https://server/send/" + VpsName + "_" + License + "?server=0&key=Activity&value=1")); 
		end;
	RecalcLastBarAfter(RecalcAfter);

end; //: LastBarOnChart_s = True

