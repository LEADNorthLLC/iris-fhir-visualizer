Class FHIR.Visualizer.REST.Service.Base Extends EnsLib.SOAP.Service
{

Method delegate(pTarget As %String, pRequest As Ens.Request, ByRef pResponse As Ens.Response) As %Status [ Internal, Private ]
{
	Set tSC = $$$OK
	Try {
		#;Add security check here
		$$$ThrowOnError(..ProcessInput(pRequest,.pResponse,pTarget))
		
	} 
	Catch Ex {
		Set tSC = Ex.AsStatus()
	}
	Quit tSC
}

Method OnProcessInput(pInput As %RegisteredObject, ByRef pOutput As %RegisteredObject, pTarget As %String) As %Status
{
	Set tSC = ..SendRequestSync(pTarget,pInput,.pOutput)
	
	#;Determine if result message should contain processing error
	Set tReturnError=0
	///CnR:How should an error be determined? 
	
	If tReturnError && $$$ISERR(pOutput.Status) {
		#;Note StatusErrorText is not stored in result structure
		Do DecomposeStatus^%apiOBJ(pOutput.Status,.err,"-d") 
		Set tResultErrorTxt = ""
		For i=1:1:err {
			Set tResultErrorTxt = tResultErrorTxt_" "_err(i)
		}
		Set pOutput.StatusErrorText =tResultErrorTxt
	}
	QUIT tSC
}

}
