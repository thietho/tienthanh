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
                	<label>CÁC LINH KIỆN BAO GỒM</label>
                    <p>
                    	<input type="hidden" id="selectmalinhkien" name="selectmalinhkien">
                        <table style="width:auto">
                        	<thead>
                                <tr>
                                    <th>Linh kiện</th>
                                    <th>Số lượng</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="dinhluonglinhkien">
                            	
                            </tbody>
                        </table>
                        <input type="hidden" id="deldinhluong" name="deldinhluong" />
                        <input class="button" type="button" name="btnAddrow" value="Thêm dòng" onClick="selcetLinhKien()">
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
	
	$.post("?route=quanlykho/sanpham/savedinhluong", $("#frm").serialize(),
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
var dl = new DinhLuong();

<?php foreach($dinhluong as $val){ ?>
	dl.createRow("<?php echo $val['id']?>","<?php echo $val['malinhkien']?>","<?php echo $val['soluong']?>");
<?php } ?>
function selcetLinhKien()
{
	openDialog("?route=quanlykho/linhkien&opendialog=true",1000,800);
	
	list = trim($("#selectmalinhkien").val(), ',');
	arr = list.split(",");
	/*malinhkien = arr[0];
	getLinhKien("id",malinhkien,'');*/
	for(i in arr)
	{
		if(arr[i] != "<?php echo $item['id']?>")
			dl.createRow(0,arr[i],0);
	}
	
}
function DinhLuong()
{
	this.index = 0;
	this.createRow = function(id,malinhkien,soluong)
	{
		$.getJSON("?route=quanlykho/linhkien/getLinhKien&col=id&val="+malinhkien, 
		function(data) 
		{
			//var str = '<option value=""></option>';
			var row = "";
			for( i in data.linhkiens)
			{
				
				var cellid = '<input type="hidden" name="dinhluong['+ dl.index +']" value="' +id+ '">';
				var cellmalinhkien = '<input type="hidden" name="malinhkien['+dl.index+']" value="' +data.linhkiens[i].id+ '">';
				var cellsoluong = '<input type="text" name="soluong['+dl.index+']" value="'+soluong+'" class="text number" size=5 />';
				row+='						<tr id="row'+dl.index+'">';
				row+='                      	<td>'+cellid + data.linhkiens[i].tenlinhkien+' ('+data.linhkiens[i].madonvi+')</td>';
				row+='                          <td>'+cellmalinhkien+cellsoluong+'</td>';
				row+='                          <td><input type="button" class="button" value="Xóa" onclick="dl.removeRow('+dl.index+','+id+')"></td>';
				row+='                      </tr>';
			}
			$("#dinhluonglinhkien").append(row);
			dl.index++;
			numberReady();
		});	
	}
	
	this.removeRow = function(pos,dlid)
	{
		$("#deldinhluong").val($("#deldinhluong").val()+","+dlid);
		$("#row"+pos).remove();
	}
}

</script>