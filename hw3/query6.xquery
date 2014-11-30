xquery version "1.0";
declare namespace ns = "http://www.w3.org/2001/XMLSchema-instance";

<query6>
{
	let $xml := doc("company.xml")
	
	let $numDivPerEmp :=
		for $empId in $xml/Company/Employee/empId
		return count($xml/Company/WorksFor[empId=$empId])
	
	let $maxNumDiv := max($numDivPerEmp) 
	
	let $empsWithMaxNumDiv :=
		for $empWithMaxNumDiv in $xml/Company/Employee
		where count($xml/Company/WorksFor[empId=$empWithMaxNumDiv/empId]) = $maxNumDiv
		return $empWithMaxNumDiv
	
	for $emp in $empsWithMaxNumDiv
	return
		<Employee>
			<Name> { $emp/empName/text() } </Name>
			<Phone> { $emp/empPhone/text() } </Phone>
			<Office> { $emp/empOffice/text() } </Office>
		</Employee>
}
</query6>