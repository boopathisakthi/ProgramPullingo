
/****** Object:  StoredProcedure [dbo].[dashboard_totals_and_profit]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec dashboard_totals_and_profit '',''
CREATE PROCEDURE [dbo].[dashboard_totals_and_profit]
	@fdate as nvarchar(max),
	@tdate as nvarchar(max)
AS
BEGIN
declare @totalsales as decimal(18,2)
declare @totalpurchase as decimal(18,2)
declare @totalexpense as decimal(18,2)
declare @profit as decimal(18,2)
declare @suppliercount as int
declare @dealercount as int

	select @totalsales = sum(total) from sales_entry where isdeleted=0
select @totalpurchase=ISNULL(sum(total),0)  from PURCHASE_ENTRY where isdeleted=0
select @totalexpense = ISNULL(sum(total),0)  from Expenseentry where isdeleted=0
select @suppliercount = count(*) from MasterCustomer where isdeleted=0 and type='Supplier'
select @dealercount = count(*) from MasterCustomer where isdeleted=0 and type='Customer'

select @profit = (@totalsales-(@totalpurchase + @totalexpense))
select @totalsales totalsales,@totalpurchase totalpurchase,@totalexpense totalexpense ,
@suppliercount suppliercount,@dealercount dealercount,@profit profit
END

GO
/****** Object:  StoredProcedure [dbo].[Edit_BILL_List]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      

-- Author:  <Boopathi Sakthi>      

-- Create date: <29/07/2019>      

-- Description: <Description,,>      

-- =============================================      

-- exec Edit_Sales_List '1'      

CREATE PROCEDURE [dbo].[Edit_BILL_List]      

@Sys_Id As Varchar(50)      

AS      

BEGIN      

BEGIN TRY   



  select

  sysid,convert(nvarchar(10),entrydate,101)entrydate,description,total,invoiceno,customersysid,taxtype,roundoff,roundoff_type     

   from     

 BILL_ENTRY SE      

   WHERE 1=1 AND isdeleted=0 AND SE.sysid=@Sys_Id      







select sd.sys_id,SD.entry_sysid,type,spare_sysid,sparename,hsncode,salesprice,isdeleted,amount,qty,taxid,taxname,taxamount
from BILL_DETAIL SD where isdeleted=0 and entry_sysid=@Sys_Id

select sysid,mode,amount,description,billno
from BILL_PAYMENTS  where isdeleted=0 and type='customer' and trans_id=@Sys_Id


END TRY       
BEGIN CATCH      
 RAISERROR ('Error while excuting your request', 16,0)      
END CATCH      
END 

































GO
/****** Object:  StoredProcedure [dbo].[edit_expense]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      

-- Author:  <Boopathi Sakthi>      

-- Create date: <29/07/2019>      

-- Description: <Description,,>      

-- =============================================      

      

-- exec edit_expense '1','1'      

CREATE PROCEDURE [dbo].[edit_expense]      

  @Sys_Id As Varchar(50),      

  @companysysid As Varchar(50)      

AS      

BEGIN      

BEGIN TRY   

     ;      

 WITH result_set AS (      

  select       

  sysid,convert(nvarchar(10),entrydate,101)entrydate,description,total   

   from     

  Expenseentry PE      

   WHERE 1=1 AND isdeleted=0 AND PE.sysid=@Sys_Id      

 )      

 SELECT       

   *       

 FROM       

   result_set  ; 
select * from  ExpenseDetails where isdeleted=0 and entrysysid= @Sys_Id

      

END TRY       

BEGIN CATCH      

 RAISERROR ('Error while excuting your request', 16,0)      

END CATCH      

END 


GO
/****** Object:  StoredProcedure [dbo].[Edit_Purchase_List]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

      

-- exec EDIT_PURCHASE_LIST '1','1'      

CREATE PROCEDURE [dbo].[Edit_Purchase_List]      
  @Sys_Id As Varchar(50),      
  @companysysid As Varchar(50)      
AS      
BEGIN      
BEGIN TRY   
   

  select       
  sys_id,convert(nvarchar(10),entry_date,101)entry_date,supplier_sysid,description,taxtype,roundoff,roundoff_type,total,purchaseno      
   from     
  PURCHASE_ENTRY PE      
   WHERE 1=1 AND isdeleted=0 AND PE.sys_id=@Sys_Id      
   

   select sys_id,spare_sysid,sparename,purchaseprice,hsncode,taxid,qty,taxname,taxamount 
   from PURCHASE_DETAIL PD   
  WHERE 1=1 AND PD.isdeleted=0 AND PD.entry_sysid=@Sys_Id    

  select sysid,mode,amount,description,billno
   from PAYMENTS  where isdeleted=0 and type='supplier' and trans_id=@Sys_Id
      

END TRY       

BEGIN CATCH      

 RAISERROR ('Error while excuting your request', 16,0)      

END CATCH      

END 





GO
/****** Object:  StoredProcedure [dbo].[Edit_Sales_List]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Boopathi Sakthi>      
-- Create date: <29/07/2019>      
-- Description: <Description,,>      
-- =============================================      
-- exec Edit_Sales_List '1'      
CREATE PROCEDURE [dbo].[Edit_Sales_List]      
@Sys_Id As Varchar(50)      
AS      
BEGIN      
BEGIN TRY   

  select
  sysid,convert(nvarchar(10),entrydate,101)entrydate,description,total,invoiceno,customersysid,taxtype,roundoff,roundoff_type     
   from     
  SALES_ENTRY SE      
   WHERE 1=1 AND isdeleted=0 AND SE.sysid=@Sys_Id      



select sd.sys_id,SD.entry_sysid,type,spare_sysid,sparename,hsncode,salesprice,isdeleted,amount,qty,taxid,taxname,taxamount

from SALES_DETAIL SD where isdeleted=0 and entry_sysid=@Sys_Id





select sysid,mode,amount,description,billno

from PAYMENTS  where isdeleted=0 and type='customer' and trans_id=@Sys_Id





END TRY       







BEGIN CATCH      







 RAISERROR ('Error while excuting your request', 16,0)      







END CATCH      







END 

















GO
/****** Object:  StoredProcedure [dbo].[GetCompanyentry_List]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Naveen >  
-- Create date: <04/24/2019>  
-- Description: <Description,,>.  
-- =============================================  
--exec GetCompanyentry_List '1','10','','','','ASC'  
CREATE PROCEDURE [dbo].[GetCompanyentry_List]   
                      
 @intPageNo as int,                           
 @intPageSize as int,                           
 @strSearchBy as varchar(MAX),                               
 @strSearchText as varchar(MAX),  
 @strOrderBy as varchar(MAX),                               
 @strOrderdir as varchar(MAX),                                               
 @companysysid as int                 
-- @intItemCount as  int out             
AS  
BEGIN  
Declare @fromIdx as int                                
Declare @toIdx as int                  
Declare @totalcount as int                                  
                                
Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                
Set @toIdx = (@intPageNo * @intPageSize);      
  
SELECT @totalcount= COUNT(*)from MASTER_COMPANY MC   
INNER JOIN MASTER_CITY MCY ON MCY.SYS_ID=MC.city AND MCY.ISDELETED=0  
INNER JOIN MASTER_STATE MS ON MS.SYS_ID=MC.state AND MS.ISDELETED=0   
 WHERE MC.isdeleted=0   
AND                                
   (                      
     @strSearchText='' OR                           
     (@strSearchBy='name' AND MC.company_name LIKE '%'+@strSearchText+'%') OR                          
     (@strSearchBy='mobile' AND MC.state LIKE '%'+@strSearchText+'%')   
)    
;WITH TEMP AS                              
(  
SELECT ROW_NUMBER() OVER( ORDER BY   
CASE WHEN @strOrderBy='sys_id' AND @strOrderdir='desc' then MC.sys_id end desc,CASE WHEN @strOrderBy='sys_id' then MC.sys_id end,   
CASE WHEN @strOrderBy='name' AND @strOrderdir='desc' then MC.company_name end desc,CASE WHEN @strOrderBy='name' then Mc.company_name end,   
CASE WHEN @strOrderBy='mobile' AND @strOrderdir='desc' then MC.mobileno end desc,CASE WHEN @strOrderBy='mobile' then Mc.mobileno end   
) SNo,  
MC.sys_id,  
MC.email,  
MCY.CITY_NAME,  
MS.STATE_NAME,  
MC.company_name,  
MC.mobileno   
  
  
from MASTER_COMPANY MC   
INNER JOIN MASTER_CITY MCY ON MCY.SYS_ID=MC.city AND MCY.ISDELETED=0  
INNER JOIN MASTER_STATE MS ON MS.SYS_ID=MC.state AND MS.ISDELETED=0   
 WHERE MC.isdeleted=0   
 AND                                
   (                      
     @strSearchText='' OR                           
     (@strSearchBy='name' AND MC.company_name LIKE '%'+@strSearchText+'%') OR                          
     (@strSearchBy='state' AND MC.state LIKE '%'+@strSearchText+'%'))   
       
)    
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx     
select @totalcount c                                 
END  

GO
/****** Object:  StoredProcedure [dbo].[GetUser_List]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Naveen >  
-- Create date: <04/24/2019>  
-- Description: <Description,,>.  
-- =============================================  
--exec GetUser_List '1','10','','','','ASC'  
CREATE PROCEDURE [dbo].[GetUser_List]   
                      
 @intPageNo as int,                           
 @intPageSize as int,                           
 @strSearchBy as varchar(MAX),                               
 @strSearchText as varchar(MAX),  
 @strOrderBy as varchar(MAX),                               
 @strOrderdir as varchar(MAX),                                               
 @companysysid   as int              
-- @intItemCount as  int out             
AS  
BEGIN  
Declare @fromIdx as int                                
Declare @toIdx as int                  
Declare @totalcount as int                                  
                                
Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                
Set @toIdx = (@intPageNo * @intPageSize);      
  
SELECT @totalcount= COUNT(*) from MASTER_USER MU   
INNER JOIN MASTER_SETTINGS MS ON MS.sys_id=MU.usertype  
where MU.isdeleted=0   
AND                                
   (                      
     @strSearchText='' OR                           
     (@strSearchBy='name' AND MU.name LIKE '%'+@strSearchText+'%') OR                          
     (@strSearchBy='mobile' AND MU.mobile LIKE '%'+@strSearchText+'%')   
)    
;WITH TEMP AS                              
(  
SELECT ROW_NUMBER() OVER( ORDER BY   
CASE WHEN @strOrderBy='sys_id' AND @strOrderdir='desc' then MU.sys_id end desc,CASE WHEN @strOrderBy='sys_id' then MU.sys_id end,   
CASE WHEN @strOrderBy='name' AND @strOrderdir='desc' then MU.name end desc,CASE WHEN @strOrderBy='name' then MU.name end,   
CASE WHEN @strOrderBy='MU.mobile' AND @strOrderdir='desc' then MU.mobile end desc,CASE WHEN @strOrderBy='mobile' then MU.mobile end   
) SNo,  
MU.sys_id,  
MU.email,  
MU.logname,  
MU.mobile,  
MS.name UserType,  
MU.name UserName  
  
from MASTER_USER MU INNER JOIN MASTER_SETTINGS MS ON MS.sys_id=MU.usertype  
 WHERE MU.isdeleted=0   
 AND                                
   (                      
     @strSearchText='' OR                           
     (@strSearchBy='name' AND MU.name LIKE '%'+@strSearchText+'%') OR                          
     (@strSearchBy='mobile' AND MU.mobile LIKE '%'+@strSearchText+'%'))   
       
)    
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx     
select @totalcount c                                 
END  

GO
/****** Object:  StoredProcedure [dbo].[insert_customer]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================

CREATE PROCEDURE [dbo].[insert_customer] 

	@sysid as int,	
	@statecode as int,
	@name as nvarchar(50),
	@mobile as nvarchar(50),
	@companyname as nvarchar(50),
	@email as nvarchar(50),
	@gstno as nvarchar(50),
	@panno as nvarchar(50),
	@type as nvarchar(50),
	@desc as nvarchar(50),
	@state as nvarchar(50),
	@address as nvarchar(50),
	@usersysid as int,
	@companisysid as int
AS
BEGIN
	IF (@sysid = '')
		BEGIN
			INSERT INTO MasterCustomer 
			([Name],[mobile],[companyname],[email],[gstin],[panno],[type],[description],[state],[Address],[comapnysysid],[createdby],[createddate],statecode)
			VALUES
			(@name,@mobile,@companyname,@email,@gstno,@panno,@type,@desc,@state,@address,@companisysid,@usersysid,getdate(),@statecode)
		END
	ELSE
		BEGIN
			update MasterCustomer set [Name]=@name,[mobile]=@mobile,[companyname]=@companyname,[email]=@email,[gstin]=@gstno,
			[state]=@state,[Address]=@address,statecode=@statecode,
			[panno]=@panno,[type]=@type,[description]=@desc,[comapnysysid]=@companisysid,[updatedby]=@usersysid,[updateddate]=getdate()
			where sysid=@sysid
		END
END

GO
/****** Object:  StoredProcedure [dbo].[insert_masterexpanse]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================

create PROCEDURE [dbo].[insert_masterexpanse] 

	@sysid as int,	
	@expansename as nvarchar(50),
	@description as nvarchar(50),	
	@usersysid as int,
	@companisysid as int
AS
BEGIN
	IF (@sysid = '')
		BEGIN
			INSERT INTO MasterExpanse
			(expansename,description,[createdby],[createddate])
			VALUES
			(@expansename,@description,@usersysid,getdate())
		END
	ELSE
		BEGIN
			update MasterExpanse set expansename=@expansename,description=@description,[updatedby]=@usersysid,[updateddate]=getdate()
			where sysid=@sysid
		END
END

GO
/****** Object:  StoredProcedure [dbo].[list_customerlist]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================          
-- Author:  <Naveen >          
-- Create date: <04/24/2019>          
-- Description: <Description,,>.          
-- =============================================          
--exec USP_GET_PARTYLIST '1','10','','','lorry_model','ASC'          
CREATE PROCEDURE [dbo].[list_customerlist]           
                              
 @parm1 as varchar(MAX),                                   
 @parm2 as varchar(MAX),                                   
 @intPageNo as int,                                   
 @intPageSize as int,                                   
 @strSearchBy as varchar(MAX),                                       
 @strSearchText as varchar(MAX),          
 @strOrderBy as varchar(MAX),                                       
 @strOrderdir as varchar(MAX),                                                       
 @companysysid as int                                                       
				              
-- @intItemCount as  int out                     
AS          
BEGIN          
 Declare @fromIdx as int                                        
Declare @toIdx as int                          
Declare @totalcount as int                                          
                                        
Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                        
Set @toIdx = (@intPageNo * @intPageSize);              
          
SELECT @totalcount= COUNT(*)         
FROM MasterCustomer mc        
  WHERE  mc.isdeleted=0    and mc.type=@parm1    
AND                                        
   (                              
     @strSearchText='' OR                                   
      (@strSearchBy='name' AND name  LIKE '%'+@strSearchText+'%') OR          
     
     (@strSearchBy='mobile' AND mobile   LIKE '%'+@strSearchText+'%') OR           
     (@strSearchBy='type' AND type   LIKE '%'+@strSearchText+'%') OR           
     (@strSearchBy='companyname' AND companyname LIKE '%'+@strSearchText+'%')  
               
)            
;WITH TEMP AS                                      
(          
SELECT ROW_NUMBER() OVER( ORDER BY           
CASE WHEN @strOrderBy='sys_id' AND @strOrderdir='desc' then mc.sysid end desc,CASE WHEN @strOrderBy='sys_id' then mc.sysid end,           
CASE WHEN @strOrderBy='name' AND @strOrderdir='desc' then mc.name end desc,CASE WHEN @strOrderBy='Party Name' then mc.name end,           
CASE WHEN @strOrderBy='Mobile' AND @strOrderdir='desc' then mc.mobile end desc,CASE WHEN @strOrderBy='Mobile' then mc.mobile end,          
CASE WHEN @strOrderBy='companyname' AND @strOrderdir='desc' then mc.companyname end desc,CASE WHEN @strOrderBy='companyname' then mc.companyname end,          
CASE WHEN @strOrderBy='type' AND @strOrderdir='desc' then Mc.type end desc,CASE WHEN @strOrderBy='type' then Mc.type end          
) SNo,   *
 FROM MasterCustomer  mc        
WHERE mc.isdeleted=0   and mc.type=@parm1        
 AND                                        
   ((                              
     @strSearchText='' OR                                   
      (@strSearchBy='name' AND name  LIKE '%'+@strSearchText+'%') OR          
     
     (@strSearchBy='mobile' AND mobile   LIKE '%'+@strSearchText+'%') OR           
     (@strSearchBy='type' AND type   LIKE '%'+@strSearchText+'%') OR           
     (@strSearchBy='companyname' AND companyname LIKE '%'+@strSearchText+'%')  
    ))          
)            
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx             
select @totalcount c                                         
END 



GO
/****** Object:  StoredProcedure [dbo].[list_expenselist]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- =============================================      
CREATE PROCEDURE [dbo].[list_expenselist]      
 @intPageNo as int,                               
 @intPageSize as int,                               
 @strSearchBy as varchar(MAX),                                   
 @strSearchText as varchar(MAX),      
 @strOrderBy as varchar(MAX),                                   
 @strOrderdir as varchar(MAX),
 @companysysid as int        
AS      
BEGIN      
    Declare @fromIdx as int                                    
    Declare @toIdx as int                      
    Declare @totalcount as int                                      
                                    
    Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                    
    Set @toIdx = (@intPageNo * @intPageSize);          
      
   SELECT @totalcount= COUNT(*) from MasterExpanse where isdeleted=0 
  AND                                    
   (                          
     @strSearchText='' OR                               
     (@strSearchBy='expansename' AND expansename LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='description' AND description LIKE '%'+@strSearchText+'%')       
   )        
   ;WITH TEMP AS                                  
   (      
    SELECT ROW_NUMBER() OVER( ORDER BY       
    CASE WHEN @strOrderBy='sys_id' AND @strOrderdir='desc' then sysid end desc,CASE WHEN @strOrderBy='sys_id' then sysid end,       
    CASE WHEN @strOrderBy='expansename' AND @strOrderdir='desc' then expansename end desc,CASE WHEN @strOrderBy='expansename' then expansename end,       
    CASE WHEN @strOrderBy='description' AND @strOrderdir='desc' then description end desc,CASE WHEN @strOrderBy='description' then description end      
   ) SNo,  * 
   FROM MasterExpanse WHERE isdeleted=0          
   AND                                    
   (                          
     @strSearchText='' OR                               
     (@strSearchBy='category' AND expansename LIKE '%'+@strSearchText+'%') OR                              
     (@strSearchBy='description' AND description LIKE '%'+@strSearchText+'%'))       
          
)        
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx         
select @totalcount c        
END 



GO
/****** Object:  StoredProcedure [dbo].[list_expensemain]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- ============================================= 
--exec   list_expensemain '1','10','expansename','','sysid','asc','1'   
CREATE PROCEDURE [dbo].[list_expensemain]      
 @intPageNo as int,                               
 @intPageSize as int,                               
 @strSearchBy as varchar(MAX),                                   
 @strSearchText as varchar(MAX),      
 @strOrderBy as varchar(MAX),                                   
 @strOrderdir as varchar(MAX),
 @companysysid as int        
AS      
BEGIN      
    Declare @fromIdx as int                                    
    Declare @toIdx as int                      
    Declare @totalcount as int                                      
                                    
    Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                    
    Set @toIdx = (@intPageNo * @intPageSize);          
      
   SELECT @totalcount= COUNT(*) from Expenseentry  ee
   --inner join ExpenseDetails ed on ee.sysid=ed.entrysysid and ed.isdeleted=0
   where ee.isdeleted=0 
  AND                                    
   (                          
     @strSearchText='' OR                               
     (@strSearchBy='entrydate' AND CONVERT(nvarchar(50),ee.entrydate,103) LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='description' AND ee.description LIKE '%'+@strSearchText+'%')       
   )     
   group by entrydate,description,total,ee.sysid   
   ;WITH TEMP AS                                  
   (      
    SELECT ROW_NUMBER() OVER( ORDER BY       
    CASE WHEN @strOrderBy='sys_id' AND @strOrderdir='desc' then ee.sysid end desc,CASE WHEN @strOrderBy='sys_id' then ee.sysid end,       
    CASE WHEN @strOrderBy='entrydate' AND @strOrderdir='desc' then CONVERT(nvarchar(50),ee.entrydate,103) end desc,CASE WHEN @strOrderBy='entrydate' then CONVERT(nvarchar(50),ee.entrydate,103) end,       
    CASE WHEN @strOrderBy='description' AND @strOrderdir='desc' then description end desc,CASE WHEN @strOrderBy='description' then description end      
   ) SNo,CONVERT(nvarchar(50),ee.entrydate,103)entrydate,ee.description,ee.total,ee.sysid 
   FROM Expenseentry  ee
   inner join ExpenseDetails ed on ee.sysid=ed.entrysysid and ed.isdeleted=0
   where ee.isdeleted=0         
   AND                                    
   (                          
     @strSearchText='' OR                               
    (@strSearchBy='entrydate' AND CONVERT(nvarchar(50),ee.entrydate,103) LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='description' AND ee.description LIKE '%'+@strSearchText+'%')      )    
	  group by entrydate,description,total,ee.sysid   
          
)        
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx         
select @totalcount c        
END 


GO
/****** Object:  StoredProcedure [dbo].[USP_ADDEDIT_MASTER_PARTY]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Naveen>
-- Create date: <13/05/2019>
-- Description:	<insert lorry details>
-- =============================================
Create PROCEDURE [dbo].[USP_ADDEDIT_MASTER_PARTY]
	@Sysid as nvarchar(max),
	@PartyName as nvarchar(max),
	@Mobile as nvarchar(max),
	@GSTNO as nvarchar(max),
	@Address as nvarchar(max),
	@Description as nvarchar(max),
	@CompanySysid as nvarchar(max),
	@UserSysid as nvarchar(max)
	
AS
BEGIN

IF (@Sysid='')
BEGIN
	Insert Into MASTER_PARTY (party_name,mobile,gst_no,address,description,company_sysid,created_by,created_date) 
	values(@PartyName,@Mobile,@GSTNO,@Address,@Description,@CompanySysid,@UserSysid,GETDATE())
END
ELSE
BEGIN
	UPDATE MASTER_PARTY SET party_name=@PartyName,mobile=@Mobile,
	gst_no=@GSTNO,address=@Address,description=@Description,
	company_sysid = @CompanySysid,modified_by=@UserSysid,modified_date=GETDATE() WHERE sys_id=@Sysid
END
	
END


GO
/****** Object:  StoredProcedure [dbo].[USP_ADDEDIT_MASTER_PRODUCT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Naveen>  
-- Create date: <30/05/2019>  
-- Description: <insert lorry details>  
-- =============================================  
CREATE PROCEDURE [dbo].[USP_ADDEDIT_MASTER_PRODUCT]  
 @Sysid as nvarchar(max),  
 @PartyNumber as nvarchar(max),  
 @Partdesc as nvarchar(max),  
 @Category as nvarchar(max),  
 @BinLocation as nvarchar(max),  
 @Stock as nvarchar(max),  
 @CompanySysid as nvarchar(max),  
 @UserSysid as nvarchar(max)  
   
AS  
BEGIN  
  
IF (@Sysid='')  
BEGIN  
 Insert Into MASTER_PRODUCT (partnumber,partdescription,part_category,binlocation,stock,company_sysid,created_by,created_date)   
 values(@PartyNumber,@Partdesc,@Category,@BinLocation,@Stock,@CompanySysid,@UserSysid,GETDATE())  

 INSERT INTO PrductStock (productid,company_sysid,openingstock,stockinhand)VALUES
 ( IDENT_CURRENT( 'MASTER_PRODUCT' ) ,@CompanySysid,@Stock,0)
END  
ELSE  
BEGIN  
 UPDATE MASTER_PRODUCT SET partnumber=@PartyNumber,partdescription=@Partdesc,  
 part_category=@Category,binlocation=@BinLocation,stock=@Stock,  
 company_sysid = @CompanySysid,modified_by=@UserSysid,modified_date=GETDATE() WHERE sys_id=@Sysid  
END  
   
END  


GO
/****** Object:  StoredProcedure [dbo].[USP_GET_BALANCE_DETAILS]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================



--exec USP_GET_BALANCE_DETAILS '03/01/2020','03/24/2020','customer','0'

CREATE PROCEDURE [dbo].[USP_GET_BALANCE_DETAILS]

	@fdate as VARCHAR(MAX),

	@tdate as VARCHAR(MAX),

	@type as varchar(max),

	@sysid as varchar(max)

AS

BEGIN

	iF(@type='customer')

	begin

			select ROW_NUMBER() OVER(order by Name asc)sno,Name,COUNT(*)TotalInvoice,mobile,ISNULL(SUM(total),0)total,

		(ISNULL(SUM(total),0)-(Select ISNULL(sum(amount),0)amount

		 from PAYMENTS PE INNER JOIN SALES_ENTRY SE ON SE.sysid=PE.trans_id and SE.isdeleted=0 

		 where type='customer' and PE.isdeleted=0  and trans_id=SE.sysid 

		and  SE.entrydate between @fdate and @tdate))balance

		 from SALES_ENTRY SE

		INNER JOIN MasterCustomer MC ON MC.sysid=SE.customersysid where (@sysid='0' or SE.customersysid=@sysid) and  SE.isdeleted=0 and 

		SE.entrydate between @fdate and @tdate   group by Name,mobile

	end

	else

	begin

			select ROW_NUMBER() OVER(order by Name asc)sno,Name,COUNT(*)TotalInvoice,mobile,ISNULL(SUM(total),0)total,

		(ISNULL(SUM(total),0)-(Select ISNULL(sum(amount),0)amount from PAYMENTS P INNER JOIN PURCHASE_ENTRY PE ON PE.sys_id=P.trans_id and PE.isdeleted=0 where type='supplier' and PE.isdeleted=0  and trans_id=PE.sys_id and  PE.entry_date between @fdate and @tdate))balance


		 from PURCHASE_ENTRY PE

		INNER JOIN MasterCustomer MC ON MC.sysid=PE.supplier_sysid where (@sysid='0' or PE.supplier_sysid=@sysid) and PE.isdeleted=0 and PE.entry_date between @fdate and @tdate group by Name,mobile

	end

END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_BILL_REPORT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================







-- Author:		<Author,,Name>







-- Create date: <Create Date,,>







-- Description:	<Description,,>







-- =============================================















--exec USP_GET_SALES_REPORT '2'







CREATE PROCEDURE [dbo].[USP_GET_BILL_REPORT]
	@SYSID as INT
AS
BEGIN

   SELECT convert(varchar(10),entrydate,105)entrydate,NAMe customername,MC.gstin,panno,Address,mobile,MS.STATE_NAME,invoiceno FROM BILL_ENTRY SE
   INNER JOIN MASTERCUSTOMER MC on MC.sysid=SE.customersysid and MC.isdeleted=0
   INNER JOIN MASTER_STATE MS on MS.sys_id=MC.state and MS.isdeleted=0
    where SE.sysid=@SYSID and SE.isdeleted=0


	

   SELECT ROW_NUMBER() over(order by sys_id asc)sno,sparename,hsncode,qty,salesprice rate,amount assessablevalue,taxid,
   taxname,cast((taxamount/2) as decimal(18,2))cgst,cast((taxamount/2) as decimal(18,2))sgst,
  (case when taxtype='Exclusive' then (amount+taxamount) else (amount) end)amount  FROM BILL_DETAIL SD
   inner join BILL_ENTRY SE ON SE.sysid=SD.entry_sysid and se.isdeleted=0
    where entry_sysid=@SYSID and SD.isdeleted=0





  select sum(cast((taxamount/2) as decimal(18,2)))cgst,sum(cast((taxamount/2) as decimal(18,2)))sgst,sum(amount)assessablevalue,taxid,taxname,
 case when taxtype='Exclusive' then (sum(amount)+sum(taxamount)) else (sum(amount)) end amount
  FROM BILL_DETAIL SD  
	inner join BILL_ENTRY SE ON SE.sysid=SD.entry_sysid and se.isdeleted=0  where entry_sysid=@SYSID and sd.isdeleted=0 group by taxid,taxname,taxtype





   select sum(cast((taxamount/2) as decimal(18,2)))cgst,sum(cast((taxamount/2) as decimal(18,2)))sgst,sum(amount)assessablevalue,taxid,taxname,
	 (SELECT   (case when taxtype='Exclusive' then (sum(amount)+sum(taxamount)) else (sum(amount)) end) FROM BILL_DETAIL SD   inner join BILL_ENTRY SE ON SE.sysid=SD.entry_sysid and se.isdeleted=0 where entry_sysid=@SYSID group by taxtype)amount
	  from BILL_DETAIL where entry_sysid=@SYSID and isdeleted=0 group by taxid,taxname


END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_BILLLIST]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                    



-- Author:  <Naveen >                    



-- Create date: <04/24/2019>                    



-- Description: <Description,,>.                    



-- =============================================                    



--exec USP_GET_SALESLIST '1','10','','','lorry_model','ASC','1'                    



CREATE PROCEDURE [dbo].[USP_GET_BILLLIST]                     



                                        



 @intPageNo as int,                                             



 @intPageSize as int,                                             



 @strSearchBy as varchar(MAX),                                                 



 @strSearchText as varchar(MAX),                    



 @strOrderBy as varchar(MAX),                                                 



 @strOrderdir as varchar(MAX),                                                               



 @companysysid as int                                      



-- @intItemCount as  int out                               



AS                    



BEGIN                    



 Declare @fromIdx as int                                                  



Declare @toIdx as int                                    



Declare @totalcount as int                                                    



                                                  



Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                                  



Set @toIdx = (@intPageNo * @intPageSize);                        



                    



SELECT @totalcount= COUNT(*)                   
FROM BILL_ENTRY SE        
 INNER JOIN MasterCustomer MC On MC.sysid=SE.customersysid and MC.isdeleted=0     
 INNER JOIN MASTER_USER MU ON MU.SYS_ID=SE.createdby AND MU.ISDELETED=0                 



WHERE SE.isdeleted=0 and se.company_sysid=@companysysid            

AND                                                  
   (                                        
     @strSearchText='' OR                                             
     (@strSearchBy='logname' AND logname LIKE '%'+@strSearchText+'%') OR                    
     (@strSearchBy='entrydate' AND convert(varchar(10),entrydate,105)    LIKE '%'+@strSearchText+'%') OR  
	 (@strSearchBy='customername' AND  MC.Name   LIKE '%'+@strSearchText+'%') OR                                
     (@strSearchBy='invoiceno' AND SE.invoiceno LIKE '%'+@strSearchText+'%')                      

)                      

;WITH TEMP AS                                                
(                    
SELECT ROW_NUMBER() OVER( ORDER BY                     
CASE WHEN @strOrderBy='sysid' AND @strOrderdir='desc' then SE.sysid end desc,CASE WHEN @strOrderBy='sysid' then SE.sysid end,                     
CASE WHEN @strOrderBy='entrydate' AND @strOrderdir='desc' then entrydate end desc,CASE WHEN @strOrderBy='entrydate' then entrydate end,                    
CASE WHEN @strOrderBy='logname' AND @strOrderdir='desc' then logname end desc,CASE WHEN @strOrderBy='logname' then logname end,                    
CASE WHEN @strOrderBy='invoiceno' AND @strOrderdir='desc' then invoiceno end desc,CASE WHEN @strOrderBy='invoiceno' then invoiceno end                    
) SNo,                    
SE.sysid,                    
CONVERT(VARCHAR(10),entrydate,105)entrydate,   
invoiceno,                 
 MC.Name,         
 logname,                
 (total-(select ISNULL(sum(amount),0) from BILL_PAYMENTS where trans_id=SE.sysid and type='customer' and isdeleted=0))balance,
total                 

 FROM BILL_ENTRY SE         
 INNER JOIN MASTER_USER MU ON MU.SYS_ID=SE.createdby AND MU.ISDELETED=0  
 INNER JOIN MasterCustomer MC On MC.sysid=SE.customersysid and MC.isdeleted=0     
 WHERE SE.isdeleted=0 and se.company_sysid=@companysysid              



 AND                                                  
   ((                                        
     @strSearchText='' OR                                             
     (@strSearchBy='logname' AND logname LIKE '%'+@strSearchText+'%') OR                    
     (@strSearchBy='customername' AND MC.Name   LIKE '%'+@strSearchText+'%') OR  
     (@strSearchBy='entrydate' AND convert(varchar(10),entrydate,105)   LIKE '%'+@strSearchText+'%') OR                     
     (@strSearchBy='invoiceno' AND SE.invoiceno LIKE '%'+@strSearchText+'%')             
    ))                    



)                      



SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx                  
select @totalcount c                                                   



END 

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_BILLPAYMENT_CUSTOMER_LIST]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                    

-- Author:  <Naveen >                    

-- Create date: <04/24/2019>                    

-- Description: <Description,,>.                    

-- =============================================                    

--exec USP_GET_BILLPAYMENT_CUSTOMER_LIST '1','10','','','lorry_model','ASC','1'                    

CREATE PROCEDURE [dbo].[USP_GET_BILLPAYMENT_CUSTOMER_LIST]                     
 @intPageNo as int,                                             
 @intPageSize as int,                                             
 @strSearchBy as varchar(MAX),                                                 
 @strSearchText as varchar(MAX),                    
 @strOrderBy as varchar(MAX),                                                 
 @strOrderdir as varchar(MAX),                                                               
 @companysysid as int  ,
 @type as varchar(max)                                    

-- @intItemCount as  int out                               

AS                    

BEGIN                    

 Declare @fromIdx as int                                                  
 Declare @toIdx as int                                    
 Declare @totalcount as int                                                    

                                                  

Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                                  
Set @toIdx = (@intPageNo * @intPageSize);                        

                    

SELECT @totalcount= COUNT(*)                   
 from Payments PE 
inner join MasterCustomer MC on MC.sysid=PE.typeid and MC.type=@type
 where billno !='purchase' and billno !='sales' and PE.isdeleted=0 and PE.companysysid=@companysysid          

AND                                                  

   (                                        
     @strSearchText='' OR                                             
     (@strSearchBy='billno' AND billno   LIKE '%'+@strSearchText+'%') OR  
	 (@strSearchBy='billdate' AND billdate   LIKE '%'+@strSearchText+'%') OR                                
     (@strSearchBy='Name' AND Name LIKE '%'+@strSearchText+'%')                      
)   group by billno,billdate,paidamount,Name,mode                       

;WITH TEMP AS                                                

(                    

SELECT             

  ROW_NUMBER() over(order by billno desc)sno,billno,convert(varchar(10),billdate,101)billdate,paidamount,MC.Name,mode             
  from Payments PE 
  inner join MasterCustomer MC on MC.sysid=PE.typeid  and MC.type=@type
  where billno !='purchase' and billno !='sales' and PE.isdeleted=0 and PE.companysysid=@companysysid          

AND                                                  
   (                                        
     @strSearchText='' OR                                             
     (@strSearchBy='billno' AND billno   LIKE '%'+@strSearchText+'%') OR  
	 (@strSearchBy='billdate' AND billdate   LIKE '%'+@strSearchText+'%') OR                                
     (@strSearchBy='Name' AND Name LIKE '%'+@strSearchText+'%')                      
)  group by billno,billdate,paidamount,Name,mode  
)
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx                  

select @totalcount c                                                   

END 

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_DAYREPORT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================
--exec USP_GET_DAYREPORT '1','04/01/2020','04/08/2020'


CREATE PROCEDURE [dbo].[USP_GET_DAYREPORT]
	@COMPANY_SYS_ID AS NVARCHAR(MAX), 
    @FROM_DATE AS NVARCHAR(MAX),  
    @TO_DATE AS NVARCHAR(MAX)
	
AS

BEGIN
  
select convert(varchar(10),entrydate,105)entrydate,total,invoiceno transaction_no,'Receipt' as type,Name from SALES_ENTRY SE
inner join MasterCustomer MC on MC.sysid=SE.customersysid  where 
SE.isdeleted=0 and convert(varchar(10),entrydate,101) BETWEEN convert(varchar(10),@FROM_DATE,101)  AND convert(varchar(10),@TO_DATE,101) and SE.company_sysid=@COMPANY_SYS_ID

select convert(varchar(10),entry_date,105)entrydate,total,purchaseno transaction_no,'Purchase' as type,Name from PURCHASE_ENTRY PE
inner join MasterCustomer MC on MC.sysid=PE.supplier_sysid 
 where PE.isdeleted=0  and PE.company_sysid=@COMPANY_SYS_ID and convert(varchar(10),entry_date,101) BETWEEN convert(varchar(10),@FROM_DATE,101)  AND convert(varchar(10),@TO_DATE,101)

select convert(varchar(10),entrydate,105)entrydate,total,'-' as transaction_no,'Expense' as type,name Name from Expenseentry EE
inner join MASTER_USER MU on MU.sys_id=EE.createdby 
 where EE.isdeleted=0 and EE.companysysid=@COMPANY_SYS_ID  and  convert(varchar(10),entrydate,101) BETWEEN convert(varchar(10),@FROM_DATE,101)  AND convert(varchar(10),@TO_DATE,101)
	 

   

END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_EDIT_PAYMENTS]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_GET_EDIT_PAYMENTS]
	@billno as varchar(max)
AS
BEGIN
		select sysid,billno,convert(varchar(10),billdate,101)billdate,type,typeid,mode,description,paidamount,trans_id,trans_no,convert(varchar(10),trans_date,101)trans_date,amount,balance,trans_total 
                    from PAYMENTS where billno=@billno
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_OVERALL_PURCHASE_REPORT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================

--exec USP_GET_OVERALL_SALES_REPORT

CREATE PROCEDURE [dbo].[USP_GET_OVERALL_PURCHASE_REPORT]

	@COMPANY_SYS_ID AS NVARCHAR(MAX), 

    @FROM_DATE AS NVARCHAR(MAX),  

    @TO_DATE AS NVARCHAR(MAX),

	@CUSTOMER_SYSID as vARCHAR(MAX)  

AS

BEGIN

	select ROW_NUMBER() over(order by PE.sys_id desc)sno,PE.sys_id,purchaseno,convert(varchar(10),entry_date,105)entrydate,Name,cast(total as decimal(18,2))total

 from PURCHASE_ENTRY PE

 inner join MasterCustomer MC on MC.sysid=PE.supplier_sysid and MC.isdeleted=0

   where PE.isdeleted=0 and (@CUSTOMER_SYSID='0' or PE.supplier_sysid=@CUSTOMER_SYSID)

   AND convert(varchar(10),entry_date,101) BETWEEN convert(varchar(10),@FROM_DATE,101)  AND convert(varchar(10),@TO_DATE,101) and PE.company_sysid=@COMPANY_SYS_ID  

END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_OVERALL_SALES_REPORT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================

--exec USP_GET_OVERALL_SALES_REPORT

CREATE PROCEDURE [dbo].[USP_GET_OVERALL_SALES_REPORT]

	@COMPANY_SYS_ID AS NVARCHAR(MAX), 

    @FROM_DATE AS NVARCHAR(MAX),  

    @TO_DATE AS NVARCHAR(MAX),

	@CUSTOMER_SYSID as vARCHAR(MAX)  

AS

BEGIN

	select ROW_NUMBER() over(order by SE.sysid desc)sno,SE.sysid,invoiceno,convert(varchar(10),entrydate,105)entrydate,Name,cast(total as decimal(18,2))total

 from SALES_ENTRY SE

 inner join MasterCustomer MC on MC.sysid=SE.customersysid and MC.isdeleted=0

   where SE.isdeleted=0 and (@CUSTOMER_SYSID='0' or SE.customersysid=@CUSTOMER_SYSID)

   AND convert(varchar(10),entrydate,101) BETWEEN convert(varchar(10),@FROM_DATE,101)  AND convert(varchar(10),@TO_DATE,101) and SE.company_sysid=@COMPANY_SYS_ID  

END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_PRODUCTMAPLIST]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[USP_GetCategorylist]    Script Date: 3/14/2020 8:59:07 AM ******/

-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- =============================================     
--exec USP_GET_PRODUCTMAPLIST '1',5,'','','','','1'
CREATE PROCEDURE [dbo].[USP_GET_PRODUCTMAPLIST]      
 @intPageNo as int,                               
 @intPageSize as int,                               
 @strSearchBy as varchar(MAX),                                   
 @strSearchText as varchar(MAX),      
 @strOrderBy as varchar(MAX),                                   
 @strOrderdir as varchar(MAX),
 @companysysid as int        
AS      
BEGIN      
    Declare @fromIdx as int                                    
    Declare @toIdx as int                      
    Declare @totalcount as int                                      
                                    
    Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                    
    Set @toIdx = (@intPageNo * @intPageSize);          
      
   SELECT @totalcount= COUNT(*)  from PRODUCTMAP_ENTRY PE
    INNER JOIN MASTER_USER MU on MU.sys_id=PE.createdby and MU.isdeleted=0 
	where pE.isdeleted=0 and PE.company_sysid=@companysysid   
  AND                                    
   (                          
     @strSearchText='' OR                               
     (@strSearchBy='productname' AND PE.productname LIKE '%'+@strSearchText+'%') OR
	   (@strSearchBy='hsn' AND hsn LIKE '%'+@strSearchText+'%')       
   )        
   ;WITH TEMP AS                                  
   (      
    SELECT ROW_NUMBER() OVER( ORDER BY       
    CASE WHEN @strOrderBy='sysid' AND @strOrderdir='desc' then sysid end desc,CASE WHEN @strOrderBy='sysid' then sysid end,       
    CASE WHEN @strOrderBy='productname' AND @strOrderdir='desc' then PE.productname end desc,CASE WHEN @strOrderBy='productname' then PE.productname end,       
    CASE WHEN @strOrderBy='hsn' AND @strOrderdir='desc' then hsn end desc,CASE WHEN @strOrderBy='hsn' then hsn end 
	   
   )sno,      
  MU.name,Convert(varchar(10),PE.created_date,105)created_date, PE.productname,PE.sysid,PE.hsn from PRODUCTMAP_ENTRY PE
    INNER JOIN MASTER_USER MU on MU.sys_id=PE.createdby and MU.isdeleted=0 
	where pE.isdeleted=0 and PE.company_sysid=@companysysid   
  AND                                    
   (                          
     @strSearchText='' OR                               
     (@strSearchBy='productname' AND PE.productname LIKE '%'+@strSearchText+'%') OR
	   (@strSearchBy='hsn' AND hsn LIKE '%'+@strSearchText+'%')  
     
	 
	 )       
          
)        
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx         
select @totalcount c        
END 

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_SALES_REPORT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================



-- Author:		<Author,,Name>



-- Create date: <Create Date,,>



-- Description:	<Description,,>



-- =============================================







--exec USP_GET_SALES_REPORT '2'



CREATE PROCEDURE [dbo].[USP_GET_SALES_REPORT]



	@SYSID as INT



AS



BEGIN



   SELECT convert(varchar(10),entrydate,105)entrydate,NAMe customername,MC.gstin,panno,Address,mobile,MS.STATE_NAME,invoiceno FROM SALES_ENTRY SE

   INNER JOIN MASTERCUSTOMER MC on MC.sysid=SE.customersysid and MC.isdeleted=0

   INNER JOIN MASTER_STATE MS on MS.sys_id=MC.state and MS.isdeleted=0

    where SE.sysid=@SYSID and SE.isdeleted=0







   SELECT ROW_NUMBER() over(order by sys_id asc)sno,sparename,hsncode,qty,salesprice rate,amount assessablevalue,taxid,
   taxname,cast((taxamount/2) as decimal(18,2))cgst,cast((taxamount/2) as decimal(18,2))sgst,
  (case when taxtype='Exclusive' then (amount+taxamount) else (amount) end)amount  FROM SALES_DETAIL SD
   inner join SALES_ENTRY SE ON SE.sysid=SD.entry_sysid and se.isdeleted=0
    where entry_sysid=@SYSID and SD.isdeleted=0


  select sum(cast((taxamount/2) as decimal(18,2)))cgst,sum(cast((taxamount/2) as decimal(18,2)))sgst,sum(amount)assessablevalue,taxid,taxname,
 case when taxtype='Exclusive' then (sum(amount)+sum(taxamount)) else (sum(amount)) end amount
  FROM SALES_DETAIL SD  
	inner join SALES_ENTRY SE ON SE.sysid=SD.entry_sysid and se.isdeleted=0  where entry_sysid=@SYSID and sd.isdeleted=0 group by taxid,taxname,taxtype






   select sum(cast((taxamount/2) as decimal(18,2)))cgst,sum(cast((taxamount/2) as decimal(18,2)))sgst,sum(amount)assessablevalue,taxid,taxname,
	 (SELECT   (case when taxtype='Exclusive' then (sum(amount)+sum(taxamount)) else (sum(amount)) end) FROM SALES_DETAIL SD   inner join SALES_ENTRY SE ON SE.sysid=SD.entry_sysid and se.isdeleted=0 where entry_sysid=@SYSID group by taxtype)amount
	  from SALES_DETAIL where entry_sysid=@SYSID and isdeleted=0 group by taxid,taxname







	



END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_SALESLIST]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                    

-- Author:  <Naveen >                    

-- Create date: <04/24/2019>                    

-- Description: <Description,,>.                    

-- =============================================                    

--exec USP_GET_SALESLIST '1','10','','','lorry_model','ASC','1'                    

CREATE PROCEDURE [dbo].[USP_GET_SALESLIST]                     

                                        

 @intPageNo as int,                                             

 @intPageSize as int,                                             

 @strSearchBy as varchar(MAX),                                                 

 @strSearchText as varchar(MAX),                    

 @strOrderBy as varchar(MAX),                                                 

 @strOrderdir as varchar(MAX),                                                               

 @companysysid as int                                      

-- @intItemCount as  int out                               

AS                    

BEGIN                    

 Declare @fromIdx as int                                                  

Declare @toIdx as int                                    

Declare @totalcount as int                                                    

                                                  

Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                                  

Set @toIdx = (@intPageNo * @intPageSize);                        

                    

SELECT @totalcount= COUNT(*)                   

FROM SALES_ENTRY SE        

 INNER JOIN MasterCustomer MC On MC.sysid=SE.customersysid and MC.isdeleted=0     
    

 INNER JOIN MASTER_USER MU ON MU.SYS_ID=SE.createdby AND MU.ISDELETED=0                 

WHERE SE.isdeleted=0 and se.company_sysid=@companysysid            

AND                                                  

   (                                        

     @strSearchText='' OR                                             

     (@strSearchBy='logname' AND logname LIKE '%'+@strSearchText+'%') OR                    

               

     (@strSearchBy='entrydate' AND CONVERT(varchar(10),entrydate,105)   LIKE '%'+@strSearchText+'%') OR  
	   (@strSearchBy='customername' AND  MC.Name   LIKE '%'+@strSearchText+'%') OR                                

     (@strSearchBy='invoiceno' AND SE.invoiceno LIKE '%'+@strSearchText+'%')                      

                 

                         

)                      

;WITH TEMP AS                                                

(                    

SELECT ROW_NUMBER() OVER( ORDER BY                     

CASE WHEN @strOrderBy='sysid' AND @strOrderdir='desc' then SE.sysid end desc,CASE WHEN @strOrderBy='sysid' then SE.sysid end,                     

CASE WHEN @strOrderBy='entrydate' AND @strOrderdir='desc' then entrydate end desc,CASE WHEN @strOrderBy='entrydate' then entrydate end,                    

CASE WHEN @strOrderBy='logname' AND @strOrderdir='desc' then logname end desc,CASE WHEN @strOrderBy='logname' then logname end,                    

CASE WHEN @strOrderBy='invoiceno' AND @strOrderdir='desc' then invoiceno end desc,CASE WHEN @strOrderBy='invoiceno' then invoiceno end                    

) SNo,                    

 SE.sysid,                    

CONVERT(VARCHAR(10),entrydate,105)entrydate,   
invoiceno,                 

       MC.Name,         

 logname,                

 (total-(select ISNULL(sum(amount),0) from PAYMENTS where trans_id=SE.sysid and type='customer' and isdeleted=0))balance,

total                 

                   

 FROM SALES_ENTRY SE         

 INNER JOIN MASTER_USER MU ON MU.SYS_ID=SE.createdby AND MU.ISDELETED=0  
 INNER JOIN MasterCustomer MC On MC.sysid=SE.customersysid and MC.isdeleted=0     


                

WHERE SE.isdeleted=0 and se.company_sysid=@companysysid              

 AND                                                  

   ((                                        

     @strSearchText='' OR                                             

      (@strSearchBy='logname' AND logname LIKE '%'+@strSearchText+'%') OR                    

                (@strSearchBy='customername' AND MC.Name   LIKE '%'+@strSearchText+'%') OR  

     (@strSearchBy='entrydate' AND CONVERT(varchar(10),entrydate,105)     LIKE '%'+@strSearchText+'%') OR                     

     (@strSearchBy='invoiceno' AND SE.invoiceno LIKE '%'+@strSearchText+'%')             

    ))                    

)                      

SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx                  

select @totalcount c                                                   

END 

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_SPARES_ID_SALESDETAILS]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================

--exec USP_GET_SPARES_ID_SALESDETAILS '1','04/01/2020','04/07/2020','S


CREATE PROCEDURE [dbo].[USP_GET_SPARES_ID_SALESDETAILS]
	@COMPANY_SYS_ID AS NVARCHAR(MAX), 
    @FROM_DATE AS NVARCHAR(MAX),  
    @TO_DATE AS NVARCHAR(MAX),
	@TYPE as vARCHAR(MAX) , 
	@spare_sysid as NVARCHAR(MAX)
AS

BEGIN
  
        
		select ROW_NUMBER() over(order by Name asc)sno,sum(qty)salescount,sparename,Name,SD.type,SD.spare_sysid,hsncode from SALES_DETAIL SD
		Inner join SALES_ENTRY SE ON SE.sysid=SD.entry_sysid and SE.isdeleted=0
		left join MasterCustomer MC ON MC.sysid=SE.customersysid
		 where SD.isdeleted=0 and SD.spare_sysid=@spare_sysid and
		  convert(varchar(10),entrydate,101) BETWEEN convert(varchar(10),@FROM_DATE,101)  AND convert(varchar(10),@TO_DATE,101)
		 AND SD.type=@TYPE   group by spare_sysid,sparename,Name,SD.type,hsncode

	

   

END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_SPARES_SALEDETAILS_REPORT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- Author:		<Author,,Name>

-- Create date: <Create Date,,>

-- Description:	<Description,,>

-- =============================================

--exec USP_GET_SPARES_SALEDETAILS_REPORT

CREATE PROCEDURE [dbo].[USP_GET_SPARES_SALEDETAILS_REPORT]
	@COMPANY_SYS_ID AS NVARCHAR(MAX), 
    @FROM_DATE AS NVARCHAR(MAX),  
    @TO_DATE AS NVARCHAR(MAX),
	@TYPE as vARCHAR(MAX)  
AS

BEGIN

		select  ROW_NUMBER() over(order by sparename asc)sno,sum(qty)salescount,sparename,SD.type,spare_sysid,hsncode from SALES_DETAIL SD
		Inner join SALES_ENTRY SE ON SE.sysid=SD.entry_sysid and SE.isdeleted=0
		left join MasterCustomer MC ON MC.sysid=SE.customersysid
		where SD.isdeleted=0 and SD.type=@TYPE
		AND convert(varchar(10),entrydate,101) BETWEEN convert(varchar(10),@FROM_DATE,101)  AND convert(varchar(10),@TO_DATE,101)
		and SE.company_sysid=@COMPANY_SYS_ID  
	    group by spare_sysid,sparename,SD.type,hsncode

   

END

GO
/****** Object:  StoredProcedure [dbo].[USP_GET_StockLIST]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec USP_GET_StockLIST '1',5,'','','','','1'
CREATE PROCEDURE [dbo].[USP_GET_StockLIST]      
 @intPageNo as int,                               
 @intPageSize as int,                               
 @strSearchBy as varchar(MAX),                                   
 @strSearchText as varchar(MAX),      
 @strOrderBy as varchar(MAX),                                   
 @strOrderdir as varchar(MAX),
 @companysysid as int        
AS      
BEGIN      
    Declare @fromIdx as int                                    
    Declare @toIdx as int                      
    Declare @totalcount as int                                      
                                    
    Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                    
    Set @toIdx = (@intPageNo * @intPageSize);          
      
   SELECT @totalcount= COUNT(*)   FROM PURCHASE_ENTRY PE
   INNER JOIN MasterCustomer MC on MC.sysid=PE.supplier_sysid and type='supplier' and MC.isdeleted=0
    WHERE PE.isdeleted=0 and company_sysid=@companysysid
  AND                                    
   (                          
     @strSearchText='' OR                               
        (@strSearchBy='entry_date' AND convert(varchar(10),entry_date,105) LIKE '%'+@strSearchText+'%') OR    
	     (@strSearchBy='suppliername' AND MC.Name LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='purchaseno' AND purchaseno LIKE '%'+@strSearchText+'%')     
	 
   )        
   ;WITH TEMP AS                                  
   (      
    SELECT ROW_NUMBER() OVER( ORDER BY SYS_id desc     
    
   ) sno,      
   sys_id,  
   purchaseno,    
  convert(varchar(10),entry_date,105)entrydate,
  (total-(select ISNULL(sum(amount),0) from PAYMENTS where trans_id=PE.sys_id and type='supplier' and isdeleted=0))balance,
  MC.Name,
  total,taxtype
   FROM PURCHASE_ENTRY PE
   INNER JOIN MasterCustomer MC on MC.sysid=PE.supplier_sysid and type='supplier' and MC.isdeleted=0
    WHERE PE.isdeleted=0 and company_sysid=@companysysid
            
   AND                                    
   (                          
     @strSearchText='' OR                               
    
	   (@strSearchBy='entry_date' AND convert(varchar(10),entry_date,105) LIKE '%'+@strSearchText+'%') OR    
	     (@strSearchBy='suppliername' AND MC.Name LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='purchaseno' AND purchaseno LIKE '%'+@strSearchText+'%')     
	 
	 )       
          
)        
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx         
select @totalcount c        
END 
GO
/****** Object:  StoredProcedure [dbo].[USP_GET_STOCKREPORT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[USP_GetCategorylist]    Script Date: 3/14/2020 8:59:07 AM ******/

-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- =============================================     
--exec USP_Getsparelist '1',5,'','','','','1'
CREATE PROCEDURE [dbo].[USP_GET_STOCKREPORT]      
 @intPageNo as int,                               
 @intPageSize as int,                               
 @strSearchBy as varchar(MAX),                                   
 @strSearchText as varchar(MAX),      
 @strOrderBy as varchar(MAX),                                   
 @strOrderdir as varchar(MAX),
 @companysysid as int        
AS      
BEGIN      
    Declare @fromIdx as int                                    
    Declare @toIdx as int                      
    Declare @totalcount as int                                      
                                    
    Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                    
    Set @toIdx = (@intPageNo * @intPageSize);          
      
   SELECT @totalcount= COUNT(*) from MASTER_SPARE where isdeleted=0  and company_sysid=@companysysid   
  AND                                    
   (                          
     @strSearchText='' OR                               
       (@strSearchBy='sparename' AND sparename LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='hsncode' AND hsncode LIKE '%'+@strSearchText+'%')     
   )        
   ;WITH TEMP AS                                  
   (      
    SELECT ROW_NUMBER() OVER( ORDER BY       
    CASE WHEN @strOrderBy='sysid' AND @strOrderdir='desc' then sysid end desc,CASE WHEN @strOrderBy='sysid' then sysid end,       
    CASE WHEN @strOrderBy='hsncode' AND @strOrderdir='desc' then hsncode end desc,CASE WHEN @strOrderBy='hsncode' then hsncode end,       
        CASE WHEN @strOrderBy='sparename' AND @strOrderdir='desc' then sparename end desc,CASE WHEN @strOrderBy='sparename' then sparename end  
     
   ) sno,      
   sysid,      
  sparename,hsncode,taxname,openingstock,ISNULL((ISNULL((openingstock),0)+ISNULL((stockinhand),0)),0)availbleqty from MASTER_SPARE where isdeleted=0 and company_sysid=@companysysid         
   AND                                    
   (                          
     @strSearchText='' OR                               
    
	   (@strSearchBy='sparename' AND sparename LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='hsncode' AND hsncode LIKE '%'+@strSearchText+'%')   
	 
	 )       
          
)        
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx         
select @totalcount c        
END 

GO
/****** Object:  StoredProcedure [dbo].[USP_Getsparelist]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[USP_GetCategorylist]    Script Date: 3/14/2020 8:59:07 AM ******/

-- =============================================      
-- Author:  <Author,,Name>      
-- Create date: <Create Date,,>      
-- Description: <Description,,>      
-- =============================================     
--exec USP_Getsparelist '1',5,'','','','','1'
CREATE PROCEDURE [dbo].[USP_Getsparelist]      
 @intPageNo as int,                               
 @intPageSize as int,                               
 @strSearchBy as varchar(MAX),                                   
 @strSearchText as varchar(MAX),      
 @strOrderBy as varchar(MAX),                                   
 @strOrderdir as varchar(MAX),
 @companysysid as int        
AS      
BEGIN      
    Declare @fromIdx as int                                    
    Declare @toIdx as int                      
    Declare @totalcount as int                                      
                                    
    Set @fromIdx = (@intPageNo-1) * @intPageSize+1;                                    
    Set @toIdx = (@intPageNo * @intPageSize);          
      
   SELECT @totalcount= COUNT(*) from MASTER_SPARE where isdeleted=0  and company_sysid=@companysysid   
  AND                                    
   (                          
     @strSearchText='' OR                               
      (@strSearchBy='sparename' AND sparename LIKE '%'+@strSearchText+'%') OR
	   (@strSearchBy='salesprice' AND salesprice LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='purchaseprice' AND purchaseprice LIKE '%'+@strSearchText+'%')       
   )        
   ;WITH TEMP AS                                  
   (      
    SELECT ROW_NUMBER() OVER( ORDER BY       
    CASE WHEN @strOrderBy='sysid' AND @strOrderdir='desc' then sysid end desc,CASE WHEN @strOrderBy='sysid' then sysid end,       
    CASE WHEN @strOrderBy='sparename' AND @strOrderdir='desc' then sparename end desc,CASE WHEN @strOrderBy='sparename' then sparename end,       
        CASE WHEN @strOrderBy='purchaseprice' AND @strOrderdir='desc' then purchaseprice end desc,CASE WHEN @strOrderBy='purchaseprice' then purchaseprice end,  
	CASE WHEN @strOrderBy='salesprice' AND @strOrderdir='desc' then salesprice end desc,CASE WHEN @strOrderBy='salesprice' then salesprice end      
   ) sno,      
   sysid,      
   sparename,description,purchaseprice,salesprice 
   FROM MASTER_SPARE WHERE isdeleted=0 and company_sysid=@companysysid         
   AND                                    
   (                          
     @strSearchText='' OR                               
     (@strSearchBy='sparename' AND sparename LIKE '%'+@strSearchText+'%') OR
	   (@strSearchBy='salesprice' AND salesprice LIKE '%'+@strSearchText+'%') OR    
      (@strSearchBy='purchaseprice' AND purchaseprice LIKE '%'+@strSearchText+'%')     
	 
	 )       
          
)        
SELECT * FROM TEMP WHERE SNo BETWEEN @fromIdx AND @toIdx         
select @totalcount c        
END 

GO
/****** Object:  StoredProcedure [dbo].[USP_PRODUCTMAP_EDIT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  <Boopathi Sakthi>      
-- Create date: <29/07/2019>      
-- Description: <Description,,>      
-- =============================================      
-- exec Edit_Sales_List '1'      
create PROCEDURE [dbo].[USP_PRODUCTMAP_EDIT]      
@SYSID As Varchar(50)      
AS      
BEGIN      
BEGIN TRY   

 select * from PRODUCTMAP_ENTRY   
   WHERE 1=1 AND isdeleted=0 AND sysid=@SYSID      



select PD.sysid,PD.entry_sysid,PD.spare_sysid,PD.sparename,PD.hsncode,
PD.taxname,PD.taxid,MS.salesprice,qty,amount
 from PRODUCTMAP_DETAILS PD 
 inner join MASTER_SPARE MS ON MS.sysid=PD.spare_sysid and MS.isdeleted=0
  where PD.isdeleted=0 and entry_sysid=@SYSID


END TRY       







BEGIN CATCH      







 RAISERROR ('Error while excuting your request', 16,0)      







END CATCH      







END 

















GO
/****** Object:  UserDefinedFunction [dbo].[Fn_GetCurrentStock]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================                
-- Author:  Boopathi                
-- Create date: 27-07-2019             
-- Description: Returns the Current stock of a particular product                
-- =============================================                
-- SELECT  dbo.Fn_GetCurrentStock(1,'01210-K24-900',1)                
CREATE FUNCTION [dbo].[Fn_GetCurrentStock]                
(                
 @COMPANY_SYS_ID AS INT,                
 @PART_NUMBER AS nvarchar(max),              
 @COMPANY_TYPE AS INT              
                 
)RETURNS VARCHAR(50)                
                
AS                
BEGIN                
  DECLARE @CURRENT_STOCK AS INT,                
  @PRODUCT_QTY AS INT,                  
  @SALES_QTY AS INT,          
  @PURCHASE_QTY AS INT,     
  @STOCK_INWARD_QTY AS INT,    
  @STOCK_OUTWARD_QTY AS INT,  
  @STOCK_COMMON_QTY AS INT,        
  @STOCK_COMMON_FROM_QTY AS INT ,      
  @STOCKTRANSFER_QTY AS INT             
  --@SALESRETURN_QTY AS INT                
                
   IF(@COMPANY_TYPE=1)              
   BEGIN            
               
  SELECT @PRODUCT_QTY= ISNULL(SUM(MP.stock),0) FROM MASTER_PRODUCT MP                 
  WHERE MP.company_sysid = @COMPANY_SYS_ID AND MP.ISDELETED=0 AND MP.partnumber=@PART_NUMBER         
        
   SELECT @PURCHASE_QTY= ISNULL(SUM(PD.qty),0) FROM PURCHASE_ENTRY PE                 
  INNER JOIN PURCHASE_DETAIL PD ON PE.SYS_ID = PD.entry_sysid AND PD.ISDELETED=0 AND PD.partnumber=@PART_NUMBER                
  AND PE.company_sysid = @COMPANY_SYS_ID AND PE.ISDELETED=0               
                
  SELECT @STOCK_INWARD_QTY=ISNULL(SUM(STD.transfer_qty),0) FROM STOCKTRANSFER_ENTRY ST                
  INNER JOIN STOCKTRANSFER_DETAIL STD ON ST.SYS_ID = STD.entry_sysid AND STD.ISDELETED=0 AND STD.partnumber=@PART_NUMBER              
  AND ST.to_company_sysid = @COMPANY_SYS_ID and transfer_status='Inward' AND ST.ISDELETED=0   
       
  SELECT @STOCK_OUTWARD_QTY=ISNULL(SUM(STD.transfer_qty),0) FROM STOCKTRANSFER_ENTRY ST                
  INNER JOIN STOCKTRANSFER_DETAIL STD ON ST.SYS_ID = STD.entry_sysid AND STD.ISDELETED=0 AND STD.partnumber=@PART_NUMBER              
  AND ST.from_company_sysid = @COMPANY_SYS_ID and transfer_status='Outward' AND ST.ISDELETED=0   
           
  SELECT @SALES_QTY=ISNULL(SUM(SD.sales_qty),0) FROM SALES_ENTRY SR                
  INNER JOIN SALES_DETAIL SD ON SR.SYS_ID = SD.entry_sysid AND SD.ISDELETED=0 AND SD.partnumber=@PART_NUMBER                
  AND SR.company_sysid = @COMPANY_SYS_ID AND SR.ISDELETED=0           
                  
   -- select   @CURRENT_STOCK=(@PRODUCT_QTY+@PURCHASE_QTY+@STOCK_INWARD_QTY)
                   
  SELECT @CURRENT_STOCK = (@PRODUCT_QTY+@PURCHASE_QTY+@STOCK_INWARD_QTY)-(@SALES_QTY+@STOCK_OUTWARD_QTY)             
             
  END              
  ELSE            
  BEGIN     
    
  SELECT @STOCK_OUTWARD_QTY=ISNULL(SUM(STD.transfer_qty),0) FROM STOCKTRANSFER_ENTRY ST                
  INNER JOIN STOCKTRANSFER_DETAIL STD ON ST.SYS_ID = STD.entry_sysid AND STD.ISDELETED=0 AND STD.partnumber=@PART_NUMBER              
  AND ST.to_company_sysid = @COMPANY_SYS_ID and transfer_status='Outward' AND ST.ISDELETED=0   
    
   SELECT @STOCK_COMMON_QTY=ISNULL(SUM(STD.transfer_qty),0) FROM STOCKTRANSFER_ENTRY ST                
  INNER JOIN STOCKTRANSFER_DETAIL STD ON ST.SYS_ID = STD.entry_sysid AND STD.ISDELETED=0 AND STD.partnumber='1'              
  AND ST.to_company_sysid = @COMPANY_SYS_ID and transfer_status='Common' AND ST.ISDELETED=0  
    
   SELECT @STOCK_COMMON_FROM_QTY=ISNULL(SUM(STD.transfer_qty),0) FROM STOCKTRANSFER_ENTRY ST                
  INNER JOIN STOCKTRANSFER_DETAIL STD ON ST.SYS_ID = STD.entry_sysid AND STD.ISDELETED=0 AND STD.partnumber='1'              
  AND ST.from_company_sysid = @COMPANY_SYS_ID and transfer_status='Common' AND ST.ISDELETED=0  
      
  SELECT @STOCK_INWARD_QTY=ISNULL(SUM(STD.transfer_qty),0) FROM STOCKTRANSFER_ENTRY ST                
  INNER JOIN STOCKTRANSFER_DETAIL STD ON ST.SYS_ID = STD.entry_sysid AND STD.ISDELETED=0 AND STD.partnumber=@PART_NUMBER              
  AND ST.from_company_sysid = @COMPANY_SYS_ID and transfer_status='Inward' AND ST.ISDELETED=0   
                
                
   SELECT @SALES_QTY=ISNULL(SUM(SD.sales_qty),0) FROM SALES_ENTRY SR                
   INNER JOIN SALES_DETAIL SD ON SR.SYS_ID = SD.entry_sysid AND SD.ISDELETED=0 AND SD.partnumber=@PART_NUMBER                
   AND SR.company_sysid = @COMPANY_SYS_ID AND SR.ISDELETED=0               
                  
                  
                   
  SELECT @CURRENT_STOCK = (@STOCK_OUTWARD_QTY+@STOCK_COMMON_QTY)-(@STOCK_COMMON_FROM_QTY+@STOCK_INWARD_QTY+@SALES_QTY)            
             
  END            
                  
    RETURN @CURRENT_STOCK                
END 

GO
/****** Object:  Table [dbo].[BILL_DETAIL]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BILL_DETAIL](
	[sys_id] [int] IDENTITY(1,1) NOT NULL,
	[entry_sysid] [int] NULL,
	[type] [nvarchar](50) NULL,
	[spare_sysid] [int] NULL,
	[sparename] [nvarchar](max) NULL,
	[hsncode] [nvarchar](50) NULL,
	[salesprice] [decimal](18, 2) NULL,
	[isdeleted] [bit] NULL,
	[amount] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[taxid] [int] NULL,
	[taxname] [nvarchar](max) NULL,
	[taxamount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_BILL_DETAIL] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BILL_ENTRY]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BILL_ENTRY](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[entrydate] [datetime] NULL,
	[createdby] [int] NULL,
	[created_date] [datetime] NULL,
	[modifiedby] [int] NULL,
	[modified_date] [datetime] NULL,
	[company_sysid] [bigint] NULL,
	[isdeleted] [bit] NULL,
	[description] [nvarchar](max) NULL,
	[customersysid] [int] NULL,
	[total] [decimal](18, 2) NULL,
	[invoiceno] [nvarchar](50) NULL,
	[taxtype] [nvarchar](50) NULL,
	[roundoff] [decimal](18, 2) NULL,
	[roundoff_type] [nvarchar](50) NULL,
 CONSTRAINT [PK_BILL_ENTRY] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BILL_PAYMENTS]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BILL_PAYMENTS](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[billno] [nvarchar](50) NULL,
	[billdate] [datetime] NULL,
	[type] [nvarchar](50) NULL,
	[typeid] [int] NULL,
	[mode] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[paidamount] [decimal](18, 2) NULL,
	[trans_id] [int] NULL,
	[trans_no] [nvarchar](50) NULL,
	[trans_date] [datetime] NULL,
	[amount] [decimal](18, 2) NULL,
	[companysysid] [int] NULL,
	[createdby] [int] NULL,
	[created_date] [datetime] NULL,
	[updatedby] [int] NULL,
	[updated_date] [datetime] NULL,
	[isdeleted] [bit] NOT NULL,
	[balance] [decimal](18, 2) NULL,
	[trans_total] [decimal](18, 2) NULL,
 CONSTRAINT [PK_BILL_PAYMENTS_1] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExpenseDetails]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExpenseDetails](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[entrysysid] [int] NULL,
	[expenseid] [int] NULL,
	[expensedesc] [nvarchar](50) NULL,
	[paymode] [nvarchar](50) NULL,
	[refrense] [nvarchar](50) NULL,
	[amount] [decimal](18, 2) NULL,
	[isdeleted] [bit] NULL,
 CONSTRAINT [PK_ExpenseDetails_1] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Expenseentry]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expenseentry](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[entrydate] [datetime] NULL,
	[description] [nvarchar](50) NULL,
	[companysysid] [int] NULL,
	[isdeleted] [bit] NULL,
	[createdby] [int] NULL,
	[updatedby] [int] NULL,
	[createddate] [datetime] NULL,
	[updateddate] [datetime] NULL,
	[total] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Expenseentry] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MASTER_CITY]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASTER_CITY](
	[SYS_ID] [int] IDENTITY(1,1) NOT NULL,
	[CITY_NAME] [nvarchar](max) NULL,
	[CITY_CODE] [nvarchar](max) NULL,
	[ISDELETED] [int] NULL,
 CONSTRAINT [PK_MASTER_CITY] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MASTER_COMPANY]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASTER_COMPANY](
	[sys_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [nvarchar](max) NULL,
	[gst_no] [nvarchar](50) NULL,
	[panno] [nvarchar](50) NULL,
	[address1] [nvarchar](max) NULL,
	[address2] [nvarchar](max) NULL,
	[pincode] [nvarchar](50) NULL,
	[city] [int] NULL,
	[state] [int] NULL,
	[telephoneno] [nvarchar](50) NULL,
	[mobileno] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[bankname] [nvarchar](50) NULL,
	[branchname] [nvarchar](50) NULL,
	[accountholdername] [nvarchar](50) NULL,
	[accountnumber] [nvarchar](50) NULL,
	[ifscecode] [nvarchar](50) NULL,
	[isdeleted] [bit] NULL,
	[type] [nvarchar](50) NULL,
 CONSTRAINT [PK_MASTER_COMPANY] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MASTER_PRODUCT]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASTER_PRODUCT](
	[sys_id] [int] IDENTITY(1,1) NOT NULL,
	[partnumber] [nvarchar](max) NULL,
	[partdescription] [nvarchar](max) NULL,
	[hsn_code] [nvarchar](50) NULL,
	[stock] [int] NULL,
	[purchase_price] [decimal](18, 2) NULL,
	[sales_price] [decimal](18, 2) NULL,
	[created_by] [int] NULL,
	[created_date] [datetime] NULL,
	[modified_by] [int] NULL,
	[modified_date] [datetime] NULL,
	[company_sysid] [int] NULL,
	[isdeleted] [bit] NULL,
	[part_category] [int] NULL,
	[binlocation] [nvarchar](50) NULL,
 CONSTRAINT [PK_MASTER_PRODUCT] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MASTER_SETTINGS]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASTER_SETTINGS](
	[sys_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](50) NULL,
	[type] [nvarchar](max) NULL,
	[isdeleted] [bit] NULL,
 CONSTRAINT [PK_MASTER-SETTINGS] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MASTER_SPARE]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASTER_SPARE](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[sparename] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[company_sysid] [int] NULL,
	[createdby] [int] NULL,
	[created_date] [datetime] NULL,
	[updatedby] [int] NULL,
	[updated_date] [datetime] NULL,
	[isdeleted] [bit] NULL,
	[purchaseprice] [decimal](18, 2) NULL,
	[salesprice] [decimal](18, 2) NULL,
	[taxid] [int] NULL,
	[openingstock] [int] NULL,
	[stockinhand] [int] NULL,
	[hsncode] [nvarchar](50) NULL,
	[taxname] [nvarchar](max) NULL,
 CONSTRAINT [PK_MASTER_SPARE] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MASTER_STATE]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASTER_STATE](
	[SYS_ID] [int] IDENTITY(1,1) NOT NULL,
	[STATE_NAME] [nvarchar](max) NULL,
	[STATE_CODE] [nvarchar](max) NULL,
	[DESCRIPTION] [nvarchar](max) NULL,
	[ISDELETED] [bit] NULL,
 CONSTRAINT [PK_MASTER_STATE] PRIMARY KEY CLUSTERED 
(
	[SYS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MASTER_USER]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASTER_USER](
	[sys_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[mobile] [nvarchar](50) NULL,
	[usertype] [nvarchar](50) NULL,
	[img] [nvarchar](max) NULL,
	[logname] [nvarchar](50) NULL,
	[pwd] [nvarchar](max) NULL,
	[company_sysid] [int] NULL,
	[isdeleted] [bit] NULL,
 CONSTRAINT [PK_MASTER_USER] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MasterCustomer]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterCustomer](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[mobile] [nvarchar](50) NULL,
	[companyname] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[state] [int] NULL,
	[Address] [nvarchar](50) NULL,
	[statecode] [int] NULL,
	[gstin] [nvarchar](50) NULL,
	[panno] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[isdeleted] [bit] NULL,
	[createdby] [int] NULL,
	[createddate] [datetime] NULL,
	[updatedby] [int] NULL,
	[updateddate] [datetime] NULL,
	[description] [nvarchar](max) NULL,
	[comapnysysid] [int] NULL,
 CONSTRAINT [PK_MasterCustomer] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MasterExpanse]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MasterExpanse](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[expansename] [nvarchar](50) NULL,
	[description] [nvarchar](50) NULL,
	[isdeleted] [bit] NULL,
	[companysysid] [int] NULL,
	[createdby] [int] NULL,
	[updatedby] [int] NULL,
	[createddate] [datetime] NULL,
	[updateddate] [datetime] NULL,
 CONSTRAINT [PK_MasterExpanse] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PAYMENTS]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAYMENTS](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[billno] [nvarchar](50) NULL,
	[billdate] [datetime] NULL,
	[type] [nvarchar](50) NULL,
	[typeid] [int] NULL,
	[mode] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[paidamount] [decimal](18, 2) NULL,
	[trans_id] [int] NULL,
	[trans_no] [nvarchar](50) NULL,
	[trans_date] [datetime] NULL,
	[amount] [decimal](18, 2) NULL,
	[companysysid] [int] NULL,
	[createdby] [int] NULL,
	[created_date] [datetime] NULL,
	[updatedby] [int] NULL,
	[updated_date] [datetime] NULL,
	[isdeleted] [bit] NOT NULL,
	[balance] [decimal](18, 2) NULL,
	[trans_total] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PAYMENTS_1] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCTMAP_DETAILS]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTMAP_DETAILS](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[entry_sysid] [int] NULL,
	[spare_sysid] [int] NULL,
	[sparename] [nvarchar](max) NULL,
	[hsncode] [nvarchar](50) NULL,
	[taxname] [nvarchar](max) NULL,
	[taxid] [int] NULL,
	[salesprice] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[amount] [decimal](18, 2) NULL,
	[isdeleted] [bit] NULL,
 CONSTRAINT [PK_PRODUCTMAP_DETAILS] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRODUCTMAP_ENTRY]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTMAP_ENTRY](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[productname] [nvarchar](max) NULL,
	[hsn] [nvarchar](50) NULL,
	[gst5amount] [decimal](18, 2) NULL,
	[gst12amount] [decimal](18, 2) NULL,
	[gst18amount] [decimal](18, 2) NULL,
	[gst28amount] [decimal](18, 2) NULL,
	[description] [nvarchar](max) NULL,
	[company_sysid] [int] NULL,
	[createdby] [int] NULL,
	[created_date] [datetime] NULL,
	[updatedby] [int] NULL,
	[updated_date] [datetime] NULL,
	[isdeleted] [bit] NULL,
 CONSTRAINT [PK_PRODUCT_ENTRY] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PURCHASE_DETAIL]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PURCHASE_DETAIL](
	[sys_id] [int] IDENTITY(1,1) NOT NULL,
	[entry_sysid] [int] NULL,
	[qty] [int] NULL,
	[isdeleted] [bit] NULL,
	[sparename] [varchar](max) NULL,
	[purchaseprice] [varchar](max) NULL,
	[spare_sysid] [int] NULL,
	[hsncode] [varchar](max) NULL,
	[taxid] [int] NULL,
	[taxname] [nvarchar](50) NULL,
	[taxamount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_PURCHASE_DETAIL] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PURCHASE_ENTRY]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PURCHASE_ENTRY](
	[sys_id] [bigint] IDENTITY(1,1) NOT NULL,
	[supplier_sysid] [bigint] NULL,
	[entry_date] [datetime] NULL,
	[created_by] [bigint] NULL,
	[created_date] [datetime] NULL,
	[modified_by] [bigint] NULL,
	[modified_date] [datetime] NULL,
	[company_sysid] [bigint] NULL,
	[isdeleted] [bit] NULL,
	[branch_sysid] [int] NULL,
	[description] [nvarchar](max) NULL,
	[inward_sysid] [int] NULL,
	[taxtype] [nvarchar](50) NULL,
	[roundoff] [decimal](18, 2) NULL,
	[roundoff_type] [nvarchar](50) NULL,
	[total] [decimal](18, 2) NULL,
	[purchaseno] [nvarchar](50) NULL,
 CONSTRAINT [PK_PURCHASE_ENTRY] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role_Rights]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Rights](
	[Sys_Id] [int] IDENTITY(1,1) NOT NULL,
	[PageName] [nvarchar](50) NULL,
	[Controler_Name] [nvarchar](50) NULL,
	[ActionName] [nvarchar](50) NULL,
	[Role_SysId] [nvarchar](50) NULL,
 CONSTRAINT [PK_Role_Rights] PRIMARY KEY CLUSTERED 
(
	[Sys_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SALES_DETAIL]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALES_DETAIL](
	[sys_id] [int] IDENTITY(1,1) NOT NULL,
	[entry_sysid] [int] NULL,
	[type] [nvarchar](50) NULL,
	[spare_sysid] [int] NULL,
	[sparename] [nvarchar](max) NULL,
	[hsncode] [nvarchar](50) NULL,
	[salesprice] [decimal](18, 2) NULL,
	[isdeleted] [bit] NULL,
	[amount] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[taxid] [int] NULL,
	[taxname] [nvarchar](max) NULL,
	[taxamount] [decimal](18, 2) NULL,
 CONSTRAINT [PK_SALES_DETAIL] PRIMARY KEY CLUSTERED 
(
	[sys_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SALES_ENTRY]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALES_ENTRY](
	[sysid] [int] IDENTITY(1,1) NOT NULL,
	[entrydate] [datetime] NULL,
	[createdby] [int] NULL,
	[created_date] [datetime] NULL,
	[modifiedby] [int] NULL,
	[modified_date] [datetime] NULL,
	[company_sysid] [bigint] NULL,
	[isdeleted] [bit] NULL,
	[description] [nvarchar](max) NULL,
	[customersysid] [int] NULL,
	[total] [decimal](18, 2) NULL,
	[invoiceno] [nvarchar](50) NULL,
	[taxtype] [nvarchar](50) NULL,
	[roundoff] [decimal](18, 2) NULL,
	[roundoff_type] [nvarchar](50) NULL,
 CONSTRAINT [PK_SALES_ENTRY] PRIMARY KEY CLUSTERED 
(
	[sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetPayment_Edit]    Script Date: 4/10/2020 3:16:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[FN_GetPayment_Edit]
(	
	@billno as varchar(max)
)
RETURNS TABLE 
AS
RETURN 
(
	select sysid,billno,convert(varchar(10),billdate,101)billdate,type,typeid,mode,description,paidamount,trans_id,trans_no,convert(varchar(10),trans_date,101)trans_date,amount,balance,trans_total 
                    from PAYMENTS where billno=@billno
)

GO
SET IDENTITY_INSERT [dbo].[MASTER_CITY] ON 

GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1, N'Chennai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (2, N'Coimbatore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (3, N'Madurai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (4, N'Tiruchirappalli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (5, N'Tiruppur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (6, N'	Salem', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (7, N'Erode', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (8, N'	Tirunelveli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (9, N'Trichy', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (10, N'Tiruvallur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (11, N'Thoothukudi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (12, N'Kanyakumari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (13, N'Thanjavur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (14, N'Kancheepuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (15, N'Dindigul', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (16, N'Vellore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (17, N'Cuddalore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (18, N'Thiruvannamalai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (19, N'Virudhunagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (20, N'Pudukottai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (21, N'Krishnagiri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (22, N'Sivagangai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (23, N'Nagapattinam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (24, N'Villupuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (25, N'Ramanathapuram	', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (26, N'Namakkal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (27, N'Tuticorin', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (28, N'Theni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (29, N'Tirunelveli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (30, N'	Nilgiris', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (31, N'	Villupuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (32, N'	Karur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (33, N'Dharmapuri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (34, N'Salem', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (35, N'Perambalur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (36, N'Ariyalur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (37, N'Kavali', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (38, N'Palacole', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (39, N'Sullurpeta', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (40, N'Tanuku', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (41, N'Rayachoti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (42, N'Srikalahasti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (43, N'Bapatla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (44, N'Naidupet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (45, N'Nagari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (46, N'Gudur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (47, N'Vinukonda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (48, N'Narasapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (49, N'Nuzvid', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (50, N'Markapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (51, N'Ponnur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (52, N'Kandukur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (53, N'Bobbili', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (54, N'Rayadurg', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (55, N'Samalkot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (56, N'Jaggaiahpet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (57, N'Tuni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (58, N'Amalapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (59, N'Bheemunipatnam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (60, N'Venkatagiri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (61, N'Sattenapalle', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (62, N'Pithapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (63, N'Palasa Kasibugga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (64, N'Parvathipuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (65, N'Macherla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (66, N'Gooty', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (67, N'Salur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (68, N'Mandapeta', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (69, N'Jammalamadugu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (70, N'Peddapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (71, N'Punganur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (72, N'Nidadavole', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (73, N'Repalle', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (74, N'Ramachandrapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (75, N'Kovvur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (76, N'Tiruvuru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (77, N'Uravakonda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (78, N'Narsipatnam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (79, N'Yerraguntla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (80, N'Pedana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (81, N'Puttur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (82, N'Renigunta', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (83, N'Rajam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (84, N'Srisailam Project (Right Flank Colony) Township', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (85, N'Naharlagun', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (86, N'Pasighat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (87, N'Guwahati', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (88, N'Silchar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (89, N'Dibrugarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (90, N'Nagaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (91, N'Tinsukia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (92, N'Jorhat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (93, N'Bongaigaon City', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (94, N'Dhubri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (95, N'Diphu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (96, N'North Lakhimpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (97, N'Tezpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (98, N'Karimganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (99, N'Sibsagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (100, N'Goalpara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (101, N'Barpeta', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (102, N'Lanka', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (103, N'Lumding', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (104, N'Mankachar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (105, N'Nalbari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (106, N'Rangia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (107, N'Margherita', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (108, N'Mangaldoi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (109, N'Silapathar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (110, N'Mariani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (111, N'Marigaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (112, N'Patna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (113, N'Gaya', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (114, N'Bhagalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (115, N'Muzaffarpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (116, N'Darbhanga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (117, N'Arrah', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (118, N'Begusarai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (119, N'Chhapra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (120, N'Katihar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (121, N'Munger', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (122, N'Purnia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (123, N'Saharsa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (124, N'Sasaram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (125, N'Hajipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (126, N'Dehri-on-Sone', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (127, N'Bettiah', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (128, N'Motihari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (129, N'Bagaha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (130, N'Siwan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (131, N'Kishanganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (132, N'Jamalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (133, N'Buxar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (134, N'Jehanabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (135, N'Aurangabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (136, N'Lakhisarai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (137, N'Nawada', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (138, N'Jamui', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (139, N'Sitamarhi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (140, N'Araria', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (141, N'Gopalganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (142, N'Madhubani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (143, N'Masaurhi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (144, N'Samastipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (145, N'Mokameh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (146, N'Supaul', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (147, N'Dumraon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (148, N'Arwal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (149, N'Forbesganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (150, N'BhabUrban Agglomeration', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (151, N'Narkatiaganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (152, N'Naugachhia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (153, N'Madhepura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (154, N'Sheikhpura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (155, N'Sultanganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (156, N'Raxaul Bazar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (157, N'Ramnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (158, N'Mahnar Bazar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (159, N'Warisaliganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (160, N'Revelganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (161, N'Rajgir', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (162, N'Sonepur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (163, N'Sherghati', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (164, N'Sugauli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (165, N'Makhdumpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (166, N'Maner', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (167, N'Rosera', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (168, N'Nokha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (169, N'Piro', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (170, N'Rafiganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (171, N'Marhaura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (172, N'Mirganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (173, N'Lalganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (174, N'Murliganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (175, N'Motipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (176, N'Manihari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (177, N'Sheohar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (178, N'Maharajganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (179, N'Silao', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (180, N'Barh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (181, N'Asarganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (182, N'Chandigarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (183, N'Raipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (184, N'Bhilai Nagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (185, N'Korba', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (186, N'Bilaspur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (187, N'Durg', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (188, N'Rajnandgaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (189, N'Jagdalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (190, N'Raigarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (191, N'Ambikapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (192, N'Mahasamund', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (193, N'Dhamtari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (194, N'Chirmiri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (195, N'Bhatapara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (196, N'Dalli-Rajhara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (197, N'Naila Janjgir', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (198, N'Tilda Newra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (199, N'Mungeli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (200, N'Manendragarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (201, N'Sakti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (202, N'Silvassa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (203, N'Delhi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (204, N'New Delhi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (205, N'Marmagao', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (206, N'Panaji', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (207, N'Margao', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (208, N'Mapusa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (209, N'Ahmedabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (210, N'Surat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (211, N'Vadodara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (212, N'Rajkot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (213, N'Bhavnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (214, N'Jamnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (215, N'Nadiad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (216, N'Porbandar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (217, N'Anand', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (218, N'Morvi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (219, N'Mahesana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (220, N'Bharuch', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (221, N'Vapi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (222, N'Navsari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (223, N'Veraval', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (224, N'Bhuj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (225, N'Godhra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (226, N'Palanpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (227, N'Valsad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (228, N'Patan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (229, N'Deesa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (230, N'Amreli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (231, N'Anjar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (232, N'Dhoraji', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (233, N'Khambhat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (234, N'Mahuva', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (235, N'Keshod', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (236, N'Wadhwan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (237, N'Ankleshwar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (238, N'Savarkundla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (239, N'Kadi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (240, N'Visnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (241, N'Upleta', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (242, N'Una', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (243, N'Sidhpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (244, N'Unjha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (245, N'Mangrol', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (246, N'Viramgam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (247, N'Modasa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (248, N'Palitana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (249, N'Petlad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (250, N'Kapadvanj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (251, N'Sihor', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (252, N'Wankaner', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (253, N'Limbdi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (254, N'Mandvi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (255, N'Thangadh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (256, N'Vyara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (257, N'Padra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (258, N'Lunawada', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (259, N'Rajpipla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (260, N'Vapi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (261, N'Umreth', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (262, N'Sanand', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (263, N'Rajula', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (264, N'Radhanpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (265, N'Mahemdabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (266, N'Ranavav', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (267, N'Tharad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (268, N'Mansa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (269, N'Umbergaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (270, N'Talaja', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (271, N'Vadnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (272, N'Manavadar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (273, N'Salaya', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (274, N'Vijapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (275, N'Pardi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (276, N'Rapar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (277, N'Songadh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (278, N'Lathi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (279, N'Adalaj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (280, N'Chhapra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (281, N'Faridabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (282, N'Gurgaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (283, N'Hisar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (284, N'Rohtak', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (285, N'Panipat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (286, N'Karnal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (287, N'Sonipat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (288, N'Yamunanagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (289, N'Panchkula', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (290, N'Bhiwani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (291, N'Bahadurgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (292, N'Jind', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (293, N'Sirsa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (294, N'Thanesar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (295, N'Kaithal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (296, N'Palwal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (297, N'Rewari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (298, N'Hansi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (299, N'Narnaul', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (300, N'Fatehabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (301, N'Gohana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (302, N'Tohana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (303, N'Narwana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (304, N'Mandi Dabwali', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (305, N'Charkhi Dadri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (306, N'Shahbad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (307, N'Pehowa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (308, N'Samalkha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (309, N'Pinjore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (310, N'Ladwa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (311, N'Sohna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (312, N'Safidon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (313, N'Taraori', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (314, N'Mahendragarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (315, N'Ratia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (316, N'Rania', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (317, N'Sarsod', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (318, N'Shimla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (319, N'Mandi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (320, N'Solan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (321, N'Nahan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (322, N'Sundarnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (323, N'Palampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (324, N'Srinagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (325, N'Jammu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (326, N'Baramula', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (327, N'Anantnag', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (328, N'Sopore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (329, N'KathUrban Agglomeration', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (330, N'Rajauri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (331, N'Punch', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (332, N'Udhampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (333, N'Dhanbad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (334, N'Ranchi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (335, N'Jamshedpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (336, N'Bokaro Steel City', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (337, N'Deoghar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (338, N'Phusro', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (339, N'Adityapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (340, N'Hazaribag', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (341, N'Giridih', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (342, N'Ramgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (343, N'Jhumri Tilaiya', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (344, N'Saunda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (345, N'Sahibganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (346, N'Medininagar (Daltonganj)', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (347, N'Chaibasa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (348, N'Chatra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (349, N'Gumia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (350, N'Dumka', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (351, N'Madhupur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (352, N'Chirkunda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (353, N'Pakaur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (354, N'Simdega', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (355, N'Musabani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (356, N'Mihijam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (357, N'Patratu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (358, N'Lohardaga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (359, N'Tenu dam-cum-Kathhara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (360, N'Bengaluru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (361, N'Hubli-Dharwad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (362, N'Belagavi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (363, N'Mangaluru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (364, N'Davanagere', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (365, N'Ballari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (366, N'Tumkur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (367, N'Shivamogga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (368, N'Raayachuru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (369, N'Robertson Pet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (370, N'Kolar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (371, N'Mandya', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (372, N'Udupi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (373, N'Chikkamagaluru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (374, N'Karwar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (375, N'Ranebennuru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (376, N'Ranibennur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (377, N'Ramanagaram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (378, N'Gokak', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (379, N'Yadgir', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (380, N'Rabkavi Banhatti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (381, N'Shahabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (382, N'Sirsi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (383, N'Sindhnur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (384, N'Tiptur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (385, N'Arsikere', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (386, N'Nanjangud', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (387, N'Sagara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (388, N'Sira', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (389, N'Puttur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (390, N'Athni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (391, N'Mulbagal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (392, N'Surapura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (393, N'Siruguppa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (394, N'Mudhol', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (395, N'Sidlaghatta', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (396, N'Shahpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (397, N'Saundatti-Yellamma', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (398, N'Wadi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (399, N'Manvi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (400, N'Nelamangala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (401, N'Lakshmeshwar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (402, N'Ramdurg', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (403, N'Nargund', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (404, N'Tarikere', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (405, N'Malavalli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (406, N'Savanur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (407, N'Lingsugur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (408, N'Vijayapura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (409, N'Sankeshwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (410, N'Madikeri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (411, N'Talikota', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (412, N'Sedam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (413, N'Shikaripur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (414, N'Mahalingapura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (415, N'Mudalagi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (416, N'Muddebihal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (417, N'Pavagada', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (418, N'Malur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (419, N'Sindhagi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (420, N'Sanduru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (421, N'Afzalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (422, N'Maddur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (423, N'Madhugiri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (424, N'Tekkalakote', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (425, N'Terdal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (426, N'Mudabidri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (427, N'Magadi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (428, N'Navalgund', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (429, N'Shiggaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (430, N'Shrirangapattana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (431, N'Sindagi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (432, N'Sakaleshapura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (433, N'Srinivaspur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (434, N'Ron', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (435, N'Mundargi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (436, N'Sadalagi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (437, N'Piriyapatna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (438, N'Adyar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (439, N'Mysore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (440, N'Thiruvananthapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (441, N'Kochi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (442, N'Kozhikode', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (443, N'Kollam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (444, N'Thrissur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (445, N'Palakkad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (446, N'Alappuzha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (447, N'Malappuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (448, N'Ponnani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (449, N'Vatakara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (450, N'Kanhangad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (451, N'Taliparamba', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (452, N'Koyilandy', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (453, N'Neyyattinkara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (454, N'Kayamkulam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (455, N'Nedumangad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (456, N'Kannur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (457, N'Tirur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (458, N'Kottayam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (459, N'Kasaragod', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (460, N'Kunnamkulam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (461, N'Ottappalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (462, N'Thiruvalla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (463, N'Thodupuzha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (464, N'Chalakudy', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (465, N'Changanassery', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (466, N'Punalur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (467, N'Nilambur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (468, N'Cherthala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (469, N'Perinthalmanna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (470, N'Mattannur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (471, N'Shoranur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (472, N'Varkala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (473, N'Paravoor', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (474, N'Pathanamthitta', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (475, N'Peringathur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (476, N'Attingal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (477, N'Kodungallur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (478, N'Pappinisseri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (479, N'Chittur-Thathamangalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (480, N'Muvattupuzha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (481, N'Adoor', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (482, N'Mavelikkara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (483, N'Mavoor', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (484, N'Perumbavoor', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (485, N'Vaikom', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (486, N'Palai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (487, N'Panniyannur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (488, N'Guruvayoor', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (489, N'Puthuppally', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (490, N'Panamattom', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (491, N'Indore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (492, N'Bhopal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (493, N'Jabalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (494, N'Gwalior', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (495, N'Ujjain', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (496, N'Sagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (497, N'Ratlam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (498, N'Satna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (499, N'Murwara (Katni)', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (500, N'Morena', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (501, N'Singrauli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (502, N'Rewa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (503, N'Vidisha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (504, N'Ganjbasoda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (505, N'Shivpuri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (506, N'Mandsaur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (507, N'Neemuch', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (508, N'Nagda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (509, N'Itarsi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (510, N'Sarni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (511, N'Sehore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (512, N'Mhow Cantonment', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (513, N'Seoni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (514, N'Balaghat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (515, N'Ashok Nagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (516, N'Tikamgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (517, N'Shahdol', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (518, N'Pithampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (519, N'Alirajpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (520, N'Mandla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (521, N'Sheopur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (522, N'Shajapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (523, N'Panna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (524, N'Raghogarh-Vijaypur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (525, N'Sendhwa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (526, N'Sidhi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (527, N'Pipariya', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (528, N'Shujalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (529, N'Sironj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (530, N'Pandhurna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (531, N'Nowgong', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (532, N'Mandideep', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (533, N'Sihora', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (534, N'Raisen', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (535, N'Lahar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (536, N'Maihar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (537, N'Sanawad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (538, N'Sabalgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (539, N'Umaria', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (540, N'Porsa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (541, N'Narsinghgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (542, N'Malaj Khand', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (543, N'Sarangpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (544, N'Mundi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (545, N'Nepanagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (546, N'Pasan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (547, N'Mahidpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (548, N'Seoni-Malwa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (549, N'Rehli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (550, N'Manawar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (551, N'Rahatgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (552, N'Panagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (553, N'Wara Seoni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (554, N'Tarana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (555, N'Sausar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (556, N'Rajgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (557, N'Niwari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (558, N'Mauganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (559, N'Manasa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (560, N'Nainpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (561, N'Prithvipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (562, N'Sohagpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (563, N'Nowrozabad (Khodargama)', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (564, N'Shamgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (565, N'Maharajpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (566, N'Multai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (567, N'Pali', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (568, N'Pachore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (569, N'Rau', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (570, N'Mhowgaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (571, N'Vijaypur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (572, N'Narsinghgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (573, N'Mumbai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (574, N'Pune', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (575, N'Nagpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (576, N'Thane', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (577, N'Nashik', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (578, N'Kalyan-Dombivali', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (579, N'Vasai-Virar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (580, N'Solapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (581, N'Mira-Bhayandar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (582, N'Bhiwandi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (583, N'Amravati', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (584, N'Nanded-Waghala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (585, N'Sangli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (586, N'Malegaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (587, N'Akola', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (588, N'Latur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (589, N'Dhule', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (590, N'Ahmednagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (591, N'Ichalkaranji', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (592, N'Parbhani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (593, N'Panvel', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (594, N'Yavatmal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (595, N'Achalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (596, N'Osmanabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (597, N'Nandurbar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (598, N'Satara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (599, N'Wardha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (600, N'Udgir', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (601, N'Aurangabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (602, N'Amalner', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (603, N'Akot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (604, N'Pandharpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (605, N'Shrirampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (606, N'Parli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (607, N'Washim', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (608, N'Ambejogai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (609, N'Manmad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (610, N'Ratnagiri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (611, N'Uran Islampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (612, N'Pusad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (613, N'Sangamner', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (614, N'Shirpur-Warwade', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (615, N'Malkapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (616, N'Wani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (617, N'Lonavla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (618, N'Talegaon Dabhade', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (619, N'Anjangaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (620, N'Umred', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (621, N'Palghar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (622, N'Shegaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (623, N'Ozar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (624, N'Phaltan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (625, N'Yevla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (626, N'Shahade', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (627, N'Vita', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (628, N'Umarkhed', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (629, N'Warora', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (630, N'Pachora', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (631, N'Tumsar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (632, N'Manjlegaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (633, N'Sillod', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (634, N'Arvi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (635, N'Nandura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (636, N'Vaijapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (637, N'Wadgaon Road', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (638, N'Sailu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (639, N'Murtijapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (640, N'Tasgaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (641, N'Mehkar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (642, N'Yawal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (643, N'Pulgaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (644, N'Nilanga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (645, N'Wai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (646, N'Umarga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (647, N'Paithan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (648, N'Rahuri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (649, N'Nawapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (650, N'Tuljapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (651, N'Morshi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (652, N'Purna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (653, N'Satana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (654, N'Pathri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (655, N'Sinnar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (656, N'Uchgaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (657, N'Uran', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (658, N'Pen', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (659, N'Karjat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (660, N'Manwath', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (661, N'Partur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (662, N'Sangole', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (663, N'Mangrulpir', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (664, N'Risod', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (665, N'Shirur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (666, N'Savner', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (667, N'Sasvad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (668, N'Pandharkaoda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (669, N'Talode', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (670, N'Shrigonda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (671, N'Shirdi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (672, N'Raver', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (673, N'Mukhed', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (674, N'Rajura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (675, N'Vadgaon Kasba', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (676, N'Tirora', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (677, N'Mahad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (678, N'Lonar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (679, N'Sawantwadi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (680, N'Pathardi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (681, N'Pauni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (682, N'Ramtek', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (683, N'Mul', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (684, N'Soyagaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (685, N'Mangalvedhe', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (686, N'Narkhed', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (687, N'Shendurjana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (688, N'Patur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (689, N'Mhaswad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (690, N'Loha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (691, N'Nandgaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (692, N'Warud', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (693, N'Imphal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (694, N'Thoubal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (695, N'Lilong', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (696, N'Mayang Imphal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (697, N'Shillong', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (698, N'Tura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (699, N'Nongstoin', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (700, N'Aizawl', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (701, N'Lunglei', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (702, N'Saiha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (703, N'Dimapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (704, N'Kohima', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (705, N'Zunheboto', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (706, N'Tuensang', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (707, N'Wokha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (708, N'Mokokchung', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (709, N'Bhubaneswar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (710, N'Cuttack', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (711, N'Raurkela', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (712, N'Brahmapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (713, N'Sambalpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (714, N'Puri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (715, N'Baleshwar Town', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (716, N'Baripada Town', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (717, N'Bhadrak', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (718, N'Balangir', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (719, N'Jharsuguda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (720, N'Bargarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (721, N'Paradip', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (722, N'Bhawanipatna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (723, N'Dhenkanal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (724, N'Barbil', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (725, N'Kendujhar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (726, N'Sunabeda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (727, N'Rayagada', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (728, N'Jatani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (729, N'Byasanagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (730, N'Kendrapara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (731, N'Rajagangapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (732, N'Parlakhemundi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (733, N'Talcher', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (734, N'Sundargarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (735, N'Phulabani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (736, N'Pattamundai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (737, N'Titlagarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (738, N'Nabarangapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (739, N'Soro', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (740, N'Malkangiri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (741, N'Rairangpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (742, N'Tarbha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (743, N'Pondicherry', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (744, N'Karaikal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (745, N'Yanam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (746, N'Mahe', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (747, N'Ludhiana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (748, N'Patiala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (749, N'Amritsar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (750, N'Jalandhar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (751, N'Bathinda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (752, N'Pathankot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (753, N'Hoshiarpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (754, N'Batala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (755, N'Moga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (756, N'Malerkotla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (757, N'Khanna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (758, N'Mohali', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (759, N'Barnala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (760, N'Firozpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (761, N'Phagwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (762, N'Kapurthala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (763, N'Zirakpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (764, N'Kot Kapura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (765, N'Faridkot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (766, N'Muktsar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (767, N'Rajpura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (768, N'Sangrur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (769, N'Fazilka', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (770, N'Gurdaspur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (771, N'Kharar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (772, N'Gobindgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (773, N'Mansa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (774, N'Malout', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (775, N'Nabha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (776, N'Tarn Taran', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (777, N'Jagraon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (778, N'Sunam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (779, N'Dhuri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (780, N'Firozpur Cantt.', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (781, N'Sirhind Fatehgarh Sahib', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (782, N'Rupnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (783, N'Jalandhar Cantt.', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (784, N'Samana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (785, N'Nawanshahr', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (786, N'Rampura Phul', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (787, N'Nangal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (788, N'Nakodar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (789, N'Zira', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (790, N'Patti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (791, N'Raikot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (792, N'Longowal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (793, N'Urmar Tanda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (794, N'Morinda, India', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (795, N'Phillaur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (796, N'Pattran', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (797, N'Qadian', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (798, N'Sujanpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (799, N'Mukerian', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (800, N'Talwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (801, N'Jaipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (802, N'Jodhpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (803, N'Bikaner', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (804, N'Udaipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (805, N'Ajmer', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (806, N'Bhilwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (807, N'Alwar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (808, N'Bharatpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (809, N'Pali', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (810, N'Barmer', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (811, N'Sikar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (812, N'Tonk', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (813, N'Sadulpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (814, N'Sawai Madhopur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (815, N'Nagaur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (816, N'Makrana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (817, N'Sujangarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (818, N'Sardarshahar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (819, N'Ladnu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (820, N'Ratangarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (821, N'Nokha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (822, N'Nimbahera', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (823, N'Suratgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (824, N'Rajsamand', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (825, N'Lachhmangarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (826, N'Rajgarh (Churu)', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (827, N'Nasirabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (828, N'Nohar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (829, N'Phalodi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (830, N'Nathdwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (831, N'Pilani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (832, N'Merta City', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (833, N'Sojat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (834, N'Neem-Ka-Thana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (835, N'Sirohi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (836, N'Pratapgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (837, N'Rawatbhata', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (838, N'Sangaria', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (839, N'Lalsot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (840, N'Pilibanga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (841, N'Pipar City', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (842, N'Taranagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (843, N'Vijainagar, Ajmer', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (844, N'Sumerpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (845, N'Sagwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (846, N'Ramganj Mandi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (847, N'Lakheri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (848, N'Udaipurwati', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (849, N'Losal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (850, N'Sri Madhopur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (851, N'Ramngarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (852, N'Rawatsar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (853, N'Rajakhera', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (854, N'Shahpura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (855, N'Shahpura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (856, N'Raisinghnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (857, N'Malpura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (858, N'Nadbai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (859, N'Sanchore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (860, N'Nagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (861, N'Rajgarh (Alwar)', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (862, N'Sheoganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (863, N'Sadri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (864, N'Todaraisingh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (865, N'Todabhim', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (866, N'Reengus', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (867, N'Rajaldesar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (868, N'Sadulshahar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (869, N'Sambhar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (870, N'Prantij', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (871, N'Mount Abu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (872, N'Mangrol', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (873, N'Phulera', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (874, N'Mandawa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (875, N'Pindwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (876, N'Mandalgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (877, N'Takhatgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (878, N'Chennai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (879, N'Coimbatore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (880, N'Madurai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (881, N'Tiruchirappalli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (882, N'Salem', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (883, N'Tirunelveli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (884, N'Tiruppur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (885, N'Ranipet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (886, N'Nagercoil', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (887, N'Thanjavur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (888, N'Vellore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (889, N'Kancheepuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (890, N'Erode', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (891, N'Tiruvannamalai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (892, N'Pollachi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (893, N'Rajapalayam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (894, N'Sivakasi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (895, N'Pudukkottai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (896, N'Neyveli (TS)', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (897, N'Nagapattinam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (898, N'Viluppuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (899, N'Tiruchengode', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (900, N'Vaniyambadi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (901, N'Theni Allinagaram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (902, N'Udhagamandalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (903, N'Aruppukkottai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (904, N'Paramakudi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (905, N'Arakkonam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (906, N'Virudhachalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (907, N'Srivilliputhur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (908, N'Tindivanam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (909, N'Virudhunagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (910, N'Karur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (911, N'Valparai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (912, N'Sankarankovil', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (913, N'Tenkasi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (914, N'Palani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (915, N'Pattukkottai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (916, N'Tirupathur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (917, N'Ramanathapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (918, N'Udumalaipettai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (919, N'Gobichettipalayam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (920, N'Thiruvarur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (921, N'Thiruvallur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (922, N'Panruti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (923, N'Namakkal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (924, N'Thirumangalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (925, N'Vikramasingapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (926, N'Nellikuppam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (927, N'Rasipuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (928, N'Tiruttani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (929, N'Nandivaram-Guduvancheri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (930, N'Periyakulam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (931, N'Pernampattu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (932, N'Vellakoil', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (933, N'Sivaganga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (934, N'Vadalur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (935, N'Rameshwaram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (936, N'Tiruvethipuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (937, N'Perambalur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (938, N'Usilampatti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (939, N'Vedaranyam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (940, N'Sathyamangalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (941, N'Puliyankudi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (942, N'Nanjikottai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (943, N'Thuraiyur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (944, N'Sirkali', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (945, N'Tiruchendur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (946, N'Periyasemur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (947, N'Sattur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (948, N'Vandavasi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (949, N'Tharamangalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (950, N'Tirukkoyilur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (951, N'Oddanchatram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (952, N'Palladam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (953, N'Vadakkuvalliyur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (954, N'Tirukalukundram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (955, N'Uthamapalayam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (956, N'Surandai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (957, N'Sankari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (958, N'Shenkottai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (959, N'Vadipatti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (960, N'Sholingur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (961, N'Tirupathur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (962, N'Manachanallur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (963, N'Viswanatham', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (964, N'Polur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (965, N'Panagudi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (966, N'Uthiramerur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (967, N'Thiruthuraipoondi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (968, N'Pallapatti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (969, N'Ponneri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (970, N'Lalgudi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (971, N'Natham', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (972, N'Unnamalaikadai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (973, N'P.N.Patti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (974, N'Tharangambadi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (975, N'Tittakudi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (976, N'Pacode', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (977, N'O'' Valley', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (978, N'Suriyampalayam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (979, N'Sholavandan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (980, N'Thammampatti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (981, N'Namagiripettai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (982, N'Peravurani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (983, N'Parangipettai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (984, N'Pudupattinam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (985, N'Pallikonda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (986, N'Sivagiri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (987, N'Punjaipugalur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (988, N'Padmanabhapuram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (989, N'Thirupuvanam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (990, N'Hyderabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (991, N'Warangal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (992, N'Nizamabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (993, N'Karimnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (994, N'Ramagundam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (995, N'Khammam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (996, N'Mahbubnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (997, N'Mancherial', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (998, N'Adilabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (999, N'Suryapet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1000, N'Jagtial', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1001, N'Miryalaguda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1002, N'Nirmal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1003, N'Kamareddy', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1004, N'Kothagudem', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1005, N'Bodhan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1006, N'Palwancha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1007, N'Mandamarri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1008, N'Koratla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1009, N'Sircilla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1010, N'Tandur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1011, N'Siddipet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1012, N'Wanaparthy', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1013, N'Kagaznagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1014, N'Gadwal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1015, N'Sangareddy', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1016, N'Bellampalle', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1017, N'Bhongir', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1018, N'Vikarabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1019, N'Jangaon', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1020, N'Bhadrachalam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1021, N'Bhainsa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1022, N'Farooqnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1023, N'Medak', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1024, N'Narayanpet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1025, N'Sadasivpet', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1026, N'Yellandu', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1027, N'Manuguru', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1028, N'Kyathampalle', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1029, N'Nagarkurnool', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1030, N'Agartala', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1031, N'Udaipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1032, N'Dharmanagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1033, N'Pratapgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1034, N'Kailasahar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1035, N'Belonia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1036, N'Khowai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1037, N'Lucknow', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1038, N'Kanpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1039, N'Firozabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1040, N'Agra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1041, N'Meerut', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1042, N'Varanasi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1043, N'Allahabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1044, N'Amroha', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1045, N'Moradabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1046, N'Aligarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1047, N'Saharanpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1048, N'Noida', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1049, N'Loni', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1050, N'Jhansi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1051, N'Shahjahanpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1052, N'Rampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1053, N'Modinagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1054, N'Hapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1055, N'Etawah', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1056, N'Sambhal', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1057, N'Orai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1058, N'Bahraich', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1059, N'Unnao', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1060, N'Rae Bareli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1061, N'Lakhimpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1062, N'Sitapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1063, N'Lalitpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1064, N'Pilibhit', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1065, N'Chandausi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1066, N'Hardoi ', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1067, N'Azamgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1068, N'Khair', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1069, N'Sultanpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1070, N'Tanda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1071, N'Nagina', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1072, N'Shamli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1073, N'Najibabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1074, N'Shikohabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1075, N'Sikandrabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1076, N'Shahabad, Hardoi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1077, N'Pilkhuwa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1078, N'Renukoot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1079, N'Vrindavan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1080, N'Ujhani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1081, N'Laharpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1082, N'Tilhar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1083, N'Sahaswan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1084, N'Rath', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1085, N'Sherkot', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1086, N'Kalpi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1087, N'Tundla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1088, N'Sandila', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1089, N'Nanpara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1090, N'Sardhana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1091, N'Nehtaur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1092, N'Seohara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1093, N'Padrauna', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1094, N'Mathura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1095, N'Thakurdwara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1096, N'Nawabganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1097, N'Siana', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1098, N'Noorpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1099, N'Sikandra Rao', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1100, N'Puranpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1101, N'Rudauli', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1102, N'Thana Bhawan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1103, N'Palia Kalan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1104, N'Zaidpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1105, N'Nautanwa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1106, N'Zamania', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1107, N'Shikarpur, Bulandshahr', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1108, N'Naugawan Sadat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1109, N'Fatehpur Sikri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1110, N'Shahabad, Rampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1111, N'Robertsganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1112, N'Utraula', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1113, N'Sadabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1114, N'Rasra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1115, N'Lar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1116, N'Lal Gopalganj Nindaura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1117, N'Sirsaganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1118, N'Pihani', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1119, N'Shamsabad, Agra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1120, N'Rudrapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1121, N'Soron', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1122, N'SUrban Agglomerationr', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1123, N'Samdhan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1124, N'Sahjanwa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1125, N'Rampur Maniharan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1126, N'Sumerpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1127, N'Shahganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1128, N'Tulsipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1129, N'Tirwaganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1130, N'PurqUrban Agglomerationzi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1131, N'Shamsabad, Farrukhabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1132, N'Warhapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1133, N'Powayan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1134, N'Sandi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1135, N'Achhnera', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1136, N'Naraura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1137, N'Nakur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1138, N'Sahaspur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1139, N'Safipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1140, N'Reoti', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1141, N'Sikanderpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1142, N'Saidpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1143, N'Sirsi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1144, N'Purwa', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1145, N'Parasi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1146, N'Lalganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1147, N'Phulpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1148, N'Shishgarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1149, N'Sahawar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1150, N'Samthar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1151, N'Pukhrayan', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1152, N'Obra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1153, N'Niwai', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1154, N'Dehradun', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1155, N'Hardwar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1156, N'Haldwani-cum-Kathgodam', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1157, N'Srinagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1158, N'Kashipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1159, N'Roorkee', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1160, N'Rudrapur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1161, N'Rishikesh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1162, N'Ramnagar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1163, N'Pithoragarh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1164, N'Manglaur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1165, N'Nainital', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1166, N'Mussoorie', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1167, N'Tehri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1168, N'Pauri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1169, N'Nagla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1170, N'Sitarganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1171, N'Bageshwar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1172, N'Kolkata', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1173, N'Siliguri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1174, N'Asansol', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1175, N'Raghunathganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1176, N'Kharagpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1177, N'Naihati', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1178, N'English Bazar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1179, N'Baharampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1180, N'Hugli-Chinsurah', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1181, N'Raiganj', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1182, N'Jalpaiguri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1183, N'Santipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1184, N'Balurghat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1185, N'Medinipur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1186, N'Habra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1187, N'Ranaghat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1188, N'Bankura', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1189, N'Nabadwip', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1190, N'Darjiling', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1191, N'Purulia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1192, N'Arambagh', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1193, N'Tamluk', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1194, N'AlipurdUrban Agglomerationr', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1195, N'Suri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1196, N'Jhargram', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1197, N'Gangarampur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1198, N'Rampurhat', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1199, N'Kalimpong', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1200, N'Sainthia', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1201, N'Taki', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1202, N'Murshidabad', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1203, N'Memari', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1204, N'Paschim Punropara', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1205, N'Tarakeswar', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1206, N'Sonamukhi', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1207, N'PandUrban Agglomeration', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1208, N'Mainaguri', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1209, N'Malda', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1210, N'Panchla', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1211, N'Raghunathpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1212, N'Mathabhanga', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1213, N'Monoharpur', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1214, N'Srirampore', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1215, N'Adra', NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1216, NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_CITY] ([SYS_ID], [CITY_NAME], [CITY_CODE], [ISDELETED]) VALUES (1217, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[MASTER_CITY] OFF
GO
SET IDENTITY_INSERT [dbo].[MASTER_COMPANY] ON 

GO
INSERT [dbo].[MASTER_COMPANY] ([sys_id], [company_name], [gst_no], [panno], [address1], [address2], [pincode], [city], [state], [telephoneno], [mobileno], [email], [bankname], [branchname], [accountholdername], [accountnumber], [ifscecode], [isdeleted], [type]) VALUES (1, N'NEXA PURE', N'5544SS', N'', N'', N'ddd', N'', 6, 30, N'', N'99952611142', N'bob@gamil.com', N'', N'dddrrr', N'', N'', N'', 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[MASTER_COMPANY] OFF
GO
SET IDENTITY_INSERT [dbo].[MASTER_SETTINGS] ON 

GO
INSERT [dbo].[MASTER_SETTINGS] ([sys_id], [name], [description], [type], [isdeleted]) VALUES (1, N'Admin', NULL, N'user', 0)
GO
INSERT [dbo].[MASTER_SETTINGS] ([sys_id], [name], [description], [type], [isdeleted]) VALUES (2, N'Staff', NULL, N'user', 0)
GO
INSERT [dbo].[MASTER_SETTINGS] ([sys_id], [name], [description], [type], [isdeleted]) VALUES (3, N'GST 18%', NULL, N'tax', 0)
GO
INSERT [dbo].[MASTER_SETTINGS] ([sys_id], [name], [description], [type], [isdeleted]) VALUES (5, N'GST 12%', NULL, N'tax', 0)
GO
INSERT [dbo].[MASTER_SETTINGS] ([sys_id], [name], [description], [type], [isdeleted]) VALUES (6, N'GST 5%', NULL, N'tax', 0)
GO
INSERT [dbo].[MASTER_SETTINGS] ([sys_id], [name], [description], [type], [isdeleted]) VALUES (7, N'GST 0%', NULL, N'tax', 0)
GO
INSERT [dbo].[MASTER_SETTINGS] ([sys_id], [name], [description], [type], [isdeleted]) VALUES (8, N'GST 28%', NULL, N'tax', 0)
GO
SET IDENTITY_INSERT [dbo].[MASTER_SETTINGS] OFF
GO
SET IDENTITY_INSERT [dbo].[MASTER_STATE] ON 

GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (1, N'Andhra Pradesh', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (2, N'Arunachal Pradesh', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (3, N'Assam', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (4, N'Bihar', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (5, N'Chandigarh', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (6, N'Chhattisgarh', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (7, N'Dadra and Nagar Haveli', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (8, N'Daman and Diu', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (9, N'Delhi', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (10, N'Goa', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (11, N'Gujarat', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (12, N'Haryana', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (13, N'Himachal Pradesh', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (14, N'Jammu and Kashmir', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (15, N'Jharkhand', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (16, N'Karnataka', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (17, N'Kerala', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (18, N'Lakshadweep', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (19, N'Madhya Pradesh', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (20, N'Maharashtra', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (21, N'Manipur', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (22, N'Meghalaya', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (23, N'Mizoram', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (24, N'Nagaland', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (25, N'Odisha', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (26, N'Puducherry', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (27, N'Punjab', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (28, N'Rajasthan', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (29, N'Sikkim', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (30, N'Tamil Nadu', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (31, N'Tripura', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (32, N'Uttar Pradesh', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (33, N'Uttarakhand', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (34, N'West Bengal', NULL, NULL, 0)
GO
INSERT [dbo].[MASTER_STATE] ([SYS_ID], [STATE_NAME], [STATE_CODE], [DESCRIPTION], [ISDELETED]) VALUES (35, NULL, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[MASTER_STATE] OFF
GO
SET IDENTITY_INSERT [dbo].[MASTER_USER] ON 

GO
INSERT [dbo].[MASTER_USER] ([sys_id], [name], [email], [mobile], [usertype], [img], [logname], [pwd], [company_sysid], [isdeleted]) VALUES (1, N'Boopathi Sakthi', N'Boopathisakthi52@gmail.com', N'978829975', N'1', N'~/UploadedImage/BOO[ATHI copy.jpg', N'Admin', N'CsdLAIs88pr2pnv790PNcg==', 1, 0)
GO
INSERT [dbo].[MASTER_USER] ([sys_id], [name], [email], [mobile], [usertype], [img], [logname], [pwd], [company_sysid], [isdeleted]) VALUES (2, N'naveen', N'', N'22', N'1', N'~/UploadedImage/second edit.jpg', N'sm', N'CsdLAIs88pr2pnv790PNcg==', 2, 1)
GO
INSERT [dbo].[MASTER_USER] ([sys_id], [name], [email], [mobile], [usertype], [img], [logname], [pwd], [company_sysid], [isdeleted]) VALUES (3, N's', N'', N'8883142424', N'1', N'~/UploadedImage/second edit.jpg', N's', N'xy6vFZ3PYITs6fSDG+D5qw==', 4, 1)
GO
INSERT [dbo].[MASTER_USER] ([sys_id], [name], [email], [mobile], [usertype], [img], [logname], [pwd], [company_sysid], [isdeleted]) VALUES (4, N'Tharamangalam', N'kmpmotors@yahoo.in', N'9655286611', N'1', N'~/App_Files/Images/default.png', N'Admin', N'2/Vzr6ZKuhqzPyZfCiLrkg==', 2, 1)
GO
INSERT [dbo].[MASTER_USER] ([sys_id], [name], [email], [mobile], [usertype], [img], [logname], [pwd], [company_sysid], [isdeleted]) VALUES (5, N'Naveenjks', N'', N'9788299795', N'1', N'~/UploadedImage/78-781084_best-life-inspiration-quotes-for-whatsapp-motivation-life.jpg', N'Naveen', N'r4hkTyxhQxBRZ6oaWnFlBA==', 1, 0)
GO
INSERT [dbo].[MASTER_USER] ([sys_id], [name], [email], [mobile], [usertype], [img], [logname], [pwd], [company_sysid], [isdeleted]) VALUES (6, N'rff', N'sss@gmail.com', N'9788299795', N'1', N'~/App_Files/Images/default.png', N'nexepure', N'1VxfD+97p2UppfLChp2UvzJP1kJmKAh+OvCrfINZRu4=', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[MASTER_USER] OFF
GO
ALTER TABLE [dbo].[BILL_DETAIL] ADD  CONSTRAINT [DF_BILL_DETAIL_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[BILL_ENTRY] ADD  CONSTRAINT [DF_BILL_ENTRY_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[BILL_PAYMENTS] ADD  CONSTRAINT [DF_BILL_PAYMENTS_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[ExpenseDetails] ADD  CONSTRAINT [DF_ExpenseDetails_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[Expenseentry] ADD  CONSTRAINT [DF_Expenseentry_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[MASTER_COMPANY] ADD  CONSTRAINT [DF_MASTER_COMPANY_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[MASTER_PRODUCT] ADD  CONSTRAINT [DF_MASTER_PRODUCT_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[MASTER_SETTINGS] ADD  CONSTRAINT [DF_MASTER-SETTINGS_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[MASTER_SPARE] ADD  CONSTRAINT [DF_MASTER_SPARE_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[MASTER_USER] ADD  CONSTRAINT [DF_MASTER_USER_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[MasterCustomer] ADD  CONSTRAINT [DF_MasterCustomer_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[MasterExpanse] ADD  CONSTRAINT [DF_MasterExpanse_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[PAYMENTS] ADD  CONSTRAINT [DF_PAYMENTS_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[PRODUCTMAP_DETAILS] ADD  CONSTRAINT [DF_PRODUCTMAP_DETAILS_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[PRODUCTMAP_ENTRY] ADD  CONSTRAINT [DF_PRODUCT_ENTRY_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[PURCHASE_DETAIL] ADD  CONSTRAINT [DF_PURCHASE_DETAIL_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[PURCHASE_ENTRY] ADD  CONSTRAINT [DF_PURCHASE_ENTRY_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[SALES_DETAIL] ADD  CONSTRAINT [DF_SALES_DETAIL_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[SALES_ENTRY] ADD  CONSTRAINT [DF_SALES_ENTRY_isdeleted]  DEFAULT ((0)) FOR [isdeleted]
GO
