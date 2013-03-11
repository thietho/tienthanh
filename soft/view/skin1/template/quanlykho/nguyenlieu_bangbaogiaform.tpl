
<div class="section" id="sitemaplist">

	<div class="section-title">Bảng báo giá</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Save" class="button" onClick="save()"/>
     	        <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/nguyenlieu/bangbaogia')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>
            	<p>
            		<label>Ngày</label><br />
                    <script language="javascript">
						$(function() {
							$("#ngay").datepicker({
									changeMonth: true,
									changeYear: true,
									dateFormat: 'dd-mm-yy'
									});
							});
					 </script>
					<input type="text" id="ngay" name="ngay" value="<?php echo $this->date->formatMySQLDate($item['ngay'])?>" class="text" size=60 <?php echo $readonly?>/>
                    
            	</p>
              	
                
                <p>
                	<label>Nhà cung cấp</label><br>
                    <input type="hidden" id="manhacungung" name="manhacungung" value="">
                    <span id="tennhacungcap"></span>
                    <input type="button" class="button" name="btnChonNhaCungCap" value="Chọn nhà cung cấp" onClick="selcetNhaCungCap()">
                    <input type="button" class="button" name="btnChonNhaCungCap" value="Bỏ chọn" onClick="unSelcetNhaCungCap()">
                </p>
               
                <p>
                    <label>Chi tiết phiếu nhập nguyên vật liệu</label>
                    <p>
                        <input type="hidden" id="manguyenlieu" name="manguyenlieu">
                        <table style="width:auto">
                            <thead>
                                <tr>
                                    <th>Mã nguyên vật liệu</th>
                                    <th>Tên nguyên vật liệu</th>
                                    
                                    
                                    <th>Đơn giá</th>
                                    
                                    
                                    
                                    <th>&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody id="chitiet">
                                
                            </tbody>
                        </table>
                        <input type="hidden" id="delchitiet" name="delchitiet" />
                        <input class="button" type="button" name="btnAddrow" value="Thêm dòng" onClick="selectNguyenLieu()">
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
	
	$.post("?route=quanlykho/nguyenlieu/savebangbaogia", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/nguyenlieu/bangbaogia";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}



getNhaCungCap("id","<?php echo $item['manhacungung']?>","")

function getNhaCungCap(col,val,operator)
{
	$.getJSON("?route=quanlykho/nhacungung/getNhaCungUng&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.nhacungungs)
				{
					
					$("#manhacungung").val(data.nhacungungs[i].id);
					$("#tennhacungcap").html(data.nhacungungs[i].tennhacungung);
				}
				
			});
}

function selcetNhaCungCap()
{
	/*openDialog("?route=quanlykho/nhacungung&opendialog=true",1000,800);
	
	list = trim($("#manhacungung").val(), ',');
	arr = list.split(",");
	manhacungcap = arr[0];
	getNhaCungCap("id",manhacungcap,'');*/
	$("#popup").attr('title','Chọn nhà cung cấp');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			buttons: {
				
				
				'Chọn': function() 
				{
					$('#frm_nhacungung .inputchk').each(function(index, element) {
                        if(this.checked)
						{
							//alert(this.value)
							getNhaCungCap("id",this.value,'');
						}
                    });
					$( this ).dialog( "close" );
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/nhacungung&opendialog=true",function(){
			$("#popup").dialog("open");	
		});
}

function unSelcetNhaCungCap()
{
	$("#manhacungung").val("");
	$("#tennhacungcap").html("");
}

//bat dau javascript cho chi tiet

<?php 
	$index = 0;
	
	if(count($chitiet))
	{
		foreach($chitiet as $val)
		{ 
	?>
			createRow(	"<?php echo $val['id']?>",
						"<?php echo $val['manguyenlieu']?>",
						
						
						"<?php echo $val['gia']?>"
						
					);
	<?php
			$index += 1;
		} 
	}
?>

function selectNguyenLieu()
{
	/*$('#manguyenlieu').val('');
	
	openDialog("?route=quanlykho/nguyenlieu&opendialog=true",1000,800);
	
	list = trim($("#manguyenlieu").val(), ',');
	arr = list.split(",");*/
	
	/*malinhkien = arr[0];
	getLinhKien("id",malinhkien,'');*/
	/*for(i in arr)
	{
		if(arr[i] != "<?php echo $item['id']?>")
			createRow(0,arr[i], 0, 0, "", 0);
	}*/
	$("#popup").attr('title','Chọn nguyên liệu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			buttons: {
				
				
				'Chọn': function() 
				{
					$('#frm_nguyenlieu .inputchk').each(function(index, element) {
                        if(this.checked)
						{
							//alert(this.value)
							createRow(0,this.value, 0, 0, "", 0);
						}
                    });
					$( this ).dialog( "close" );
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/nguyenlieu&opendialog=true",function(){
			$("#popup").dialog("open");	
		});
	
}

var index = 0;
function createRow(id, manguyenlieu,   dongia)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=id&val="+manguyenlieu, 
	function(data) 
	{
		var row = "";
		for( i in data.nguyenlieus)
		{
			var cellid = '<input type="hidden" name="chitiet['+index+']" value="' +id+ '">';
			var cellitemid = '<input type="hidden" name="itemid['+index+']" value="' +data.nguyenlieus[i].id + '">' + data.nguyenlieus[i].manguyenlieu;
			var celltennguyenlieu = '<input type="hidden" name="tennguyenlieu['+index+']" value="' +data.nguyenlieus[i].tennguyenlieu+ '">' + data.nguyenlieus[i].tennguyenlieu +" ("+data.nguyenlieus[i].tendonvitinh +")";
			
			
			
			var celldongia = '<input type="text" name="dongia['+index+']" value="'+dongia+'" class="text number" size=5 />';
			
			
			
			
			
			row+='						<tr id="row'+index+'">';
			row+='                          <td>'+cellid+cellitemid+'</td>';
			row+='                          <td>'+celltennguyenlieu+'</td>';
			
			
			row+='                          <td>'+celldongia+'</td>';
			
			row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+','+id+')"></td>';
			row+='                      </tr>';
		}
		$("#chitiet").append(row);
		
		if(dongia == 0)
			$("#dongia-"+index+"").val(data.nguyenlieus[i].dongia);
		
		index++;
		numberReady();
	});	
}

function removeRow(pos,id)
{
	$("#delchitiet").val($("#delchitiet").val()+","+id);
	$("#row"+pos).remove();
}
//end javascript cho chi tiet
</script>
