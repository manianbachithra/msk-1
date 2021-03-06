<!DOCTYPE html>
<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en"><head>
  <meta charset="utf-8">
  <title>Bike</title>
  <base href="/">

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/x-icon" href="favicon.ico">
  <link rel="stylesheet" href="../css/carbrands.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body cz-shortcut-listen="true">


<app-header><nav _ class="navbar navbar-inverse">
  <div _ class="container-fluid">
    <div class="navbar-header">
      <a _ class="navbar-brand" href="/">MSK Automotive</a>
    </div>
    <ul _ class="nav navbar-nav">
      <li _><a _>Home</a></li>    
      <li _><a _>Add car</a></li>
    </ul>
    
  </div>
</nav></app-header>


<div class="col-lg-12">
<div class="container">
<c:forEach var="brands" varStatus="counter"  items="${it.data.brands}">
    <div _ class="col-xs-12 col-sm-6 col-md-6 col-lg-2 col-xl-4 card grid-item">
      <div _ class="thumbnail car_brand">
       <c:if test="${brands == 'noimage'}">
<!--         <img _ class="" style="width:100%;max-height:100px" src="http://personalityanalysistest.com/template/images/logo.png">
 -->         </c:if>
        <c:if test="${brands != 'noimage'}">
        <img class="zz" style="width:100%;max-height:100px" src="${brands.logo}">
        </c:if>
        <div _ class="caption">
          <h5 id="thumbnail-label" class="brand_name">${brands.brand}</h5>
        </div>
      </div>
      <span id="brand_id" style="display:none">${brands.brand_id}</span>
    </div>
</c:forEach>
</div>
</div>


<div>


</div>

 <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
         <input id="inputFileToLoad" type="file" onchange="loadImageFileAsURL();" />
<input type="hidden" id="textAreaFileContents" name="companyLogo" />
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default upload" data-dismiss="modal">Upload</button>
        </div>
      </div>
      
    </div>
  </div>



	<form name="submitForm" method="POST" id="menuurl" action=""
		style="display: none;">
		 <input type="hidden" name="brand_id" id="brandid" value="">
		 <!-- <input type="hidden" name="brand_name" id="brandname" value=""> -->
		 <input type="hidden" name="applicationState" id="formapplicationState"
			value='${it.applicationStateJson}'> <input type="hidden"
			name="job_id" id="form_job_id" value=''> <a
			href="javascript:document.submitForm.submit()" id="formsubmit"></a>

    </form>
    
    	<form  method="POST" action="msk/upload-brand" style="display: none;">
		 <input type="hidden" name="brand_id" class="brandid" value="">
		  <input type="hidden" name="logo" id="image" value=""> 
			<input type="submit" id="subImage" > 
    </form>
    
    
    <script type="text/javascript">
    
    $(document).ready(function(){
    	
		
    		$(document).on('click','.car_brand',function(){
    			
    		
    		
    		console.log("car clickeddd");
    		
    		$('#brandid').val($(this).next().text());
    		
    		//$('#brandname').val($(this).find('.brand_name').text());
    		var str=$(this).find('.brand_name').text().replace(/ /g, "-");
    		var brand_name ="msk/"+str.toLowerCase()+"/car-models"
    		console.log("brand_name=====>"+brand_name);
    		
    	 	  window.setTimeout(function() {
    			  console.log("inside function==>"+brand_name);
    	   		 $("#menuurl").attr("action",brand_name);
    	   	     document.submitForm.submit();
    	    }, 300); 
    		
    	});
    	
    		var brandId;
    		
    	$(".choose").click(function(){
    		
    		$("#myModal").modal("show");
    		brandId=$(this).prev('span').text();
    	});
    	
    	$(".upload").click(function(){
		$("#image").val($("#textAreaFileContents").text());
		console.log("image--"+$("#textAreaFileContents").text());
		console.log("id---"+brandId);
		$(".brandid").val(brandId);
		$("#subImage").trigger("click");
    	});
    		
    		
    });
    function loadImageFileAsURL()
    {
   
        var filesSelected = document.getElementById("inputFileToLoad").files;
     	
        if (filesSelected.length > 0)
        {
            var fileToLoad = filesSelected[0];
     
            var fileReader = new FileReader();
     
            fileReader.onload = function(fileLoadedEvent) 
            {
                var textAreaFileContents = document.getElementById
                (
                    "textAreaFileContents"
                );
                textAreaFileContents.innerHTML = fileLoadedEvent.target.result;
                
                
                if($("#textAreaFileContents").text().length < 45000)
                {
                	$(".error_size").hide();
                		if( $("#textAreaFileContents").text().slice(5,10) === "image") 
                		{
                			$(".error_format").hide();
                		}

                		else 
                		{
                		$(".error_format").show();
                		}
                }
                
                else 
                {
                	$(".error_size").show();
                	
                	if($("#textAreaFileContents").text().slice(5,10) === "image") 
                	{
                		$(".error_format").hide();
                	}

                	else 
                	{
                		$(".error_format").show();
                		$(".error_size").hide();
                	}
                	
                }
            };
     
            fileReader.readAsDataURL(fileToLoad);
        }
        
    }
    </script>

</body></html>