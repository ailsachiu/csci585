xquery version "1.0";
declare namespace ns = "http://www.w3.org/2001/XMLSchema-instance";

<query5>
{
	let $xml := doc("company.xml")
	
	let $numDivPerEmp :=
		for $empId in $xml/Company/Employee/empId
		return count($xml/Company/WorksFor[empId=$empId])
	
	return 
		<Company>
			<avgNumDivPerEmp> { avg($numDivPerEmp) } </avgNumDivPerEmp>
		</Company>
}
</query5>