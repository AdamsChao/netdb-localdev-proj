SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2,Country_Manager
, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent
, country.country_name, Authority.authority_name ,world_region.world_region_name
,(Select fname from employee where id = Country_Manager ) as CountryManager
,Project.Project_Id, Project.Project_No, Project.Project_Status , Quotation_Version.Model_No
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN world_region ON world_region.world_region_id = country.world_region_id
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
INNER JOIN Quotation_Version ON Quotation_Version.Quotation_Version_Id = Quotation_Target.quotation_id
INNER JOIN Project ON Project.Quotation_No = Quotation_Version.Quotation_No
WHERE (Project.Project_No LIKE '%' + @Project_No + '%') 
AND (Project.Project_Status LIKE '%' + @Project_Status + '%') 
AND (country.country_name LIKE '%' + @country_name + '%') 
AND (world_region_name LIKE '%' + @region_name + '%') 
AND ((SELECT fname FROM employee AS employee_1 
WHERE (id = Quotation_Target.Country_Manager)) 
LIKE '%' + @CountryManager + '%')
