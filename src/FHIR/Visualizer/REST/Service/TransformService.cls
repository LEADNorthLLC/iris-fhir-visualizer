Class FHIR.Visualizer.REST.Service.TransformService Extends FHIR.Visualizer.REST.Service.Base
{

Parameter ADAPTER;

Parameter NAMESPACE = "http://visualizer.com";

Parameter SERVICECLASSNAME = "FHIR.Visualizer.REST.Service.TransformService";

/// Name of the WebService.
Parameter SERVICENAME = "FHIR.Visualizer.REST.Service.TransformService";

/// Process target for the service. <br>
/// The process is used to handle transfer request. <br>
Property ProcessTarget As Ens.DataType.ConfigName [ InitialExpression = "Transform Operation" ];

Parameter SETTINGS = "ProcessTarget";

Method TransformCCDAToSDA(pRequest As FHIR.Visualizer.Model.Record, ByRef pResponse As FHIR.Visualizer.Model.Record) As %Status [ WebMethod ]
{
	
	Quit ..delegate(..ProcessTarget,pRequest,.pResponse)
}

/*ClassMethod TransformCCDAManual(pRequest As FHIR.Visualizer.Model.Record, ByRef pResponse As FHIR.Visualizer.Model.Record) As %Status
{
	Set tSC = $$$OK
	Try {

		//Set up stream

		Set tServiceName = ##class(HS.Local.Visualizer.REST.Service.TransformService).GetFirstBusinessProcessNameFromClass($CLASSNAME($THIS))
		$$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tServiceName,.tService))
		
		Set tRequest = ##class(HS.Local.Visualizer.Model.Record).%New()
		
		$$$ThrowOnError(tService.TransformCCDAToSDA(tRequest,.pResponse))
		
	} 
	Catch Ex {
		Set tSC = Ex.AsStatus()
	}
	Quit tSC
}
*/

/// ///////////////////////////////////////////////////////////////////////////
/// ///////////////////Used to test operation without without webservice///////
/// ///////////////////////////////////////////////////////////////////////////
/// Tester method for transform
/// INPUT
/// 		
/// OUTPUT
/// 		DataQuality.DQ.Prod.Msg.BatchResponse
/// EXAMPLE
/// 	$$$ThrowOnError(##class(DataQuality.DQ.Prod.Service.BatchService).TransformCCDAManual(.tResponse))
/// 

}
