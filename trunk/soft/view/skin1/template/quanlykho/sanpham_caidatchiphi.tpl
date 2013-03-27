<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/sanpham')"/>   
     	        <input type="hidden" name="masanpham" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Mã sản phẩm: <?php echo $item['masanpham']?></label>
            	</p>
              	
                
                <p>
            		<label>Tên sản phẩm: <?php echo $item['tensanpham']?></label>
            	</p>
               	<p>
                	<label>CÁC CHI PHÍ BAO GỒM</label>
                    <p>
                    	<input type="hidden" id="selectmachiphi" name="selectmachiphi">
                        <table style="width:auto">
                        	<thead>
                                <tr>
                                    <th>Mã chi phí</th>
                                    <th>Tên chi phí</th>
                                    <th>Chi phí</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="listchiphi">
                            	
                            </tbody>
                        </table>
                        <input type="hidden" id="delchiphi" name="delchiphi" />
                        <input class="button" type="button" name="btnAddrow" value="Thêm dòng" onClick="selcetChiPhi()">
                    </p>
                </p>
                
               
               
               
            </div>
            
        </form>
    
    </div>
    
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/sanpham/savecaidatchiphi", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/sanpham";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
<?php foreach($chiphis as $val){ ?>
createRow("<?php echo $val['id']?>","<?php echo $val['machiphi']?>","<?php echo $val['chiphi']?>")
<?php } ?>
function selcetChiPhi()
{
	openDialog("?route=quanlykho/chiphi&opendialog=true",1000,800);
	
	list = trim($("#selectmachiphi").val(), ',');
	arr = list.split(",");
	
	for(i in arr)
	{
		
		createRow(0,arr[i],0);
	}
	
}
var index = 0;
function createRow(id,machiphi,chiphi)
{
	$.getJSON("?route=quanlykho/chiphi/getChiPhi&machiphi="+machiphi, 
	function(data) 
	{
		//var str = '<option value=""></option>';
		var row = "";
		
			
		var cellid = '<input type="hidden" name="id['+index+']" value="' + id+ '">';
		var cellmachiphi = '<input type="hidden" name="machiphi['+index+']" value="' +data.chiphi.machiphi+ '">';
		var cellchiphi = '<input type="text" name="chiphi['+index+']" value="'+chiphi+'" class="text number" size=5 />';
		row+='						<tr id="row'+index+'">';
		row+='                      	<td>'+cellid + data.chiphi.machiphi+'</td>';
		row+='                      	<td>'+cellid + data.chiphi.tenchiphi+'</td>';
		row+='                          <td>'+cellmachiphi+cellchiphi+'</td>';
		row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+','+id+')"></td>';
		row+='                      </tr>';
		
		$("#listchiphi").append(row);
		index++;
		numberReady();
	});	
}

function removeRow(pos,dlid)
{
	$("#delchiphi").val($("#delchiphi").val()+","+dlid);
	$("#row"+pos).remove();
}

</script>
