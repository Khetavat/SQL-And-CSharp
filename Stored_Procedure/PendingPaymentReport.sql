
create procedure Vishal_PendingPaymentReport
as
begin
select *,  t1.amt    - t2.amt from 
(
select vc.customerid,sum(vp1.plancost) amt
from Vishal_customers vc join Vishal_payments vp on vc.customerid = vp.customerid join Vishal_Plans vp1 on vc.planid = vp1.planid
where Status = 'paid'
group by
vc.customerid
) as t1 join

(
select vc.customerid,sum(ve.cost) amt
from Vishal_customers vc join Vishal_complaints vc1 on vc.customerid = vc1.customerid join Vishal_Expenses ve on vc1.complaintid = ve.complaintid
--where Status = 'paid'
group by
vc.customerid) as t2 on t1.CustomerId = t2.customerid
end