xquery version "1.0";
declare namespace ns = "http://www.w3.org/2001/XMLSchema-instance";

<query4>
{
	let $xml := doc("/Users/ailsa/csci585-hw3/company.xml")
	let $managerEmpIds := distinct-values(
		for $managerEmpId in $xml/Company/Division/managerEmpId
		order by $managerEmpId
		return $managerEmpId
		)
	
	for $empId in $xml/Company/Employee/empId[not(. = $managerEmpIds)]
	for $emp in $xml/Company/Employee[empId = $empId]
	order by $emp/empName ascending
	return
		<Employee>
			<Name> { $emp/empName/text() } </Name>
			<Phone> { $emp/empPhone/text() } </Phone>
			<Office> { $emp/empOffice/text() } </Office>
		</Employee>
}
</query4>