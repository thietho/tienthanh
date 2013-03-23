

<div class="section" id="sitemaplist">

	<div class="section-title">Phiếu nhận hàng</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieunhanhang&id=<?php echo $item['manhacungung']?>')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                	<li class="tabs-selected"><a href="#fragment-phieunhanhang"><span>Thông tin phiếu nhận hàng</span></a></li>
                    <li class="tabs"><a href="#fragment-chitietphieunhanhang"><span>Chi tiết phiếu nhận hàng</span></a></li>
                </ul>
                
                <div id="fragment-phieunhanhang" class="tabs-container">   
                    <p>
                        <label>Mã phiếu nhận hàng</label><br />
                        <input type="text" name="maphieunhanhang" value="<?php echo $item['maphieunhanhang']?>" class="text" size=60 <?php if($item['maphieunhanhang']!="") echo 'readonly="readonly"'?>/>
                    </p>  
                    <p>
                        <label>Nhà cung ứng</label><br/>
                        <input id="manhacungung" type="hidden" name="manhacungung" value="<?php echo $item['manhacungung'] ?>" class="text" size="60" />
                        <input id="tennhacungung" readonly type="text" name="tennhacungung" value="<?php echo $item['tennhacungung'] ?>" class="text" size="60" />
                    </p>   
                    <p>
                        <label>Mã hợp đồng</label><br />
                        <input type="text" name="mahopdong" value="<?php echo $item['mahopdong']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Lần giao</label><br />
                        <input type="text" class="text number" name="langiao" value="<?php echo $item['langiao']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Nhân viên tiếp nhận</label><br/>
                        <input type="hidden" name="manhanviennhanhang" value="<?php echo $item['manhanviennhanhang'] ?>" class="text" size=60 />
                        <input type="text" name="tennhanviennhanhang" value="<?php echo $item['tennhanviennhanhang'] ?>" readonly class="text" size=60 />
                    </p>
                    <p>
                        <label>Ngày lập</label><br />
                        <script language="javascript">
                            $(function() {
                                $("#ngaylap").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                         <input type="text" id="ngaylap" name="ngaylap" value="<?php echo $this->date->formatMySQLDate($item['ngaylap'])?>" class="text" size=60 />
                    </p>
                     <p>
                        <label>Ngày nhận hàng</label><br />
                        <script language="javascript">
                            $(function() {
                                $("#ngaygiao").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                         <input type="text" id="ngaygiao" name="ngaygiao" value="<?php echo $this->date->formatMySQLDate($item['ngaygiao'])?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Đánh giá số lượng</label><br/>
                        <select id="danhgiasoluong" name="danhgiasoluong">
                            <option value=""></option>
                            <?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Đánh giá chất lượng</label><br/>
                        <select id="danhgiachatluong" name="danhgiachatluong">
                            <option value=""></option>
                            <?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Đánh giá thời gian</label><br/>
                        <select id="danhgiathoigian" name="danhgiathoigian">
                            <option value=""></option>
                            <?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Đánh giá thanh toán</label><br/>
                        <select id="danhgiathanhtoan" name="danhgiathanhtoan">
                            <option value=""></option>
                            <?php foreach($this->document->danhgia as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Tình trạng thanh toán</label><br/>
                        <select id="tinhtrangthanhtoan" name="tinhtrangthanhtoan">
                            <option value=""></option>
                            <?php foreach($this->document->thanhtoan as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea name="ghichu"><?php echo $item['ghichu']?></textarea>
                    </p>
                </div>
                
                <!-- chi tiet phieu nhan hang -->
                <div id="fragment-chitietphieunhanhang" class="tabs-container">
                	
                    <p>
                        <label>Chi tiết phiếu nhận hàng</label>
                        <p>
                            <input type="hidden" id="manguyenlieu" name="manguyenlieu">
                            <table style="width:auto">
                                <thead>
                                    <tr>
                                        <th>Mã nguyên vật liệu</th>
                                        <th>Tên nguyên vật liệu</th>
                                        <th>Số lượng</th>
                                        
                                        <th>Đánh giá chất lượng</th>
                                        <th>Số lượng nhận</th>
                                        <th>Số lượng trả lại</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody id="chitiet">
                                    
                                </tbody>
                            </table>
                            <input type="hidden" id="delchitiet" name="delchitiet" />
                            <input class="button" type="button" name="btnAddrow" value="Thêm dòng" onClick="newRow()">
                        </p>
                    </p>
                
                </div>
                <!-- end chi tiet phieu nhan hang -->
                
            </div>
        </form>
    
    </div>
    
</div>
<div id="autocomplete" style="display:none;position:absolute;background:#FFF;">

</div>

<script language="javascript">
var auto = new AutoComplete();
var index = 0;
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieunhanhang/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/phieunhanhang&id=" + "<?php echo $item['manhacungung'] ?>";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$(document).ready(function() {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
});

$("#danhgiasoluong").val("<?php echo $item['danhgiasoluong']?>");
$("#danhgiachatluong").val("<?php echo $item['danhgiachatluong']?>");

$("#danhgiathoigian").val("<?php echo $item['danhgiathoigian']?>");
$("#danhgiathanhtoan").val("<?php echo $item['danhgiathanhtoan']?>");
$("#tinhtrangthanhtoan").val("<?php echo $item['tinhtrangthanhtoan']?>");

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
						"<?php echo $this->document->getnguyenLieu($val['manguyenlieu'],'manguyenlieu')?>",
						"<?php echo $val['tennguyenlieu']?>",
						"<?php echo $val['soluong']?>",
						
						"<?php echo $val['danhgiachatluong']?>",
						"<?php echo $val['soluongnhan']?>",
						"<?php echo $val['soluongtralai']?>"
					);
			//
			//setTimeout('$("#danhgiachatluongct-<?php echo $index; ?>").val("<?php echo $val['danhgiachatluong'] ?>");', 3000);
	<?php
			$index += 1;
		} 
	}
?>



function newRow()
{
	createRow("","","","", 0, 0, "", 0, 0);
}


function createRow(id,manguyenlieu,manguyenlieutext,tennuyenlieu, soluong,  danhgiachatluong, soluongnhan, soluongtralai)
{
	var row = "";
	
	var cellid = '<input type="hidden" name="chitiet['+index+']" value="' + id + '">';
	var cellmanguyenlieu = '<input type="hidden" id="manguyenlieu-'+ index +'" name="manguyenlieu['+index+']" value="' + manguyenlieu + '">';
	cellmanguyenlieu += '<input type="text" class="text gridautocomplete" size=10 id="manguyenlieutext-'+ index +'" name="manguyenlieutext['+index+']" value="' + manguyenlieutext + '">';
	var celltennguyenlieu = '<input type="text" id="tennguyenlieu-'+index+'" name="tennguyenlieu['+index+']" size=10 value="' + tennuyenlieu + '" readonly>';
	
	var cellsoluong = '<input type="text" name="soluong['+index+']" value="'+soluong+'" class="text number" size=5 />';
	
	var celldanhgiachatluong = "<select id='danhgiachatluongct-" + index + "' name='danhgiachatluongct[" + index + "]'" 
						+ "><option value=''></option>"
						+ "<?php foreach($this->document->danhgia as $key => $val){ ?>"
						+ "<option value='<?php echo $key; ?>'><?php echo $val ?></option><?php } ?>"
						+ "</select>";		
	
	var cellsoluongnhan = '<input type="text" name="soluongnhan['+index+']" value="'+soluongnhan+'" class="text number" size=5 />';
	var cellsoluongtralai = '<input type="text" name="soluongtralai['+index+']" value="'+soluongtralai+'" class="text number" size=5 />';
	
	row+='						<tr id="row'+ index +'">';
	row+='                          <td>'+cellid+cellmanguyenlieu+'</td>';
	row+='                          <td>'+celltennguyenlieu+'</td>';
	row+='                          <td>'+cellsoluong+'</td>';
	
	row+='                          <td>'+celldanhgiachatluong+'</td>';
	row+='                          <td>'+cellsoluongnhan+'</td>';
	row+='                          <td>'+cellsoluongtralai+'</td>';
	row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+','+id+')"></td>';
	row+='                      </tr>';
	
	$("#chitiet").append(row);
	$("#danhgiachatluongct-"+index+"").val(danhgiachatluong);
	index++;
	numberReady();
	auto.autocomplete();
}

function removeRow(pos,id)
{
	$("#delchitiet").val($("#delchitiet").val()+","+id);
	$("#row"+pos).remove();
}
//end javascript cho chi tiet
//Autocomplete
function AutoComplete()
{
	this.curentRow = 0;
	
	this.closeAutocomplete = function()
	{
		$("#autocomplete").hide();
		$("#autocomplete").html("");
	};
	
	this.selectRow = function()
	{
		$(".autocompleterow").removeClass("selectrow");
		$("#rowauto-" + this.curentRow).addClass("selectrow");
	};
	
	this.back = function()
	{
		if(this.curentRow>0)
		{
			this.curentRow--;
			this.selectRow();
		}
	}
	
	this.next = function()
	{
		
		if($("#rowauto-"+ (this.curentRow + 1)).html() != null)
		{
			this.curentRow++;
			this.selectRow();
		}
	}
	
	this.getValue = function()
	{
		arr = new Array();
		if($("#rowauto-"+ this.curentRow ).html()!=null)
		{
			str = $("#rowauto-"+ this.curentRow ).html();
			arr = str.split(":");
			arr[2] = $("#idnguyenlieu-"+this.curentRow).val();
			
		}
		return arr;
	}
	
	this.autocomplete = function()
	{
		$(".gridautocomplete").blur( function()
		{ 
			selectValue(this.id);
		});
		
		$(".gridautocomplete").keyup(function(event)
		{
			//Press enter
			if (event.keyCode == '13')
			{
				selectValue(this.id);
			}
			//Press button down
			if (event.keyCode == '40')
			{
				auto.next();
			}
			//Press button up
			if (event.keyCode == '38')
			{
				auto.back();
			}
			
			if(event.keyCode > 40 || event.keyCode == 8)
			{
				
				position = $(this).position();
				$("#autocomplete").css("left", position.left + "px");
				$("#autocomplete").css("top", position.top+ 35 + "px");
				$("#autocomplete").show();
				if($(this).val() != "")
				{
					getNguyenLieu("manguyenlieu",$(this).val(),"like");
					auto.curentRow = 0;
				}
				else
					auto.closeAutocomplete()
			}
		});
		
		
	};
	
	
}



function getNguyenLieu(col,val,operator)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				str = "";
				for( i in data.nguyenlieus)
				{
					str+= '<li id=rowauto-'+i+' class=autocompleterow>'+ data.nguyenlieus[i].manguyenlieu + ':' +data.nguyenlieus[i].tennguyenlieu+'</li><input type="hidden" id="idnguyenlieu-'+i+'" value="'+ data.nguyenlieus[i].id +'" />';
				}
				$("#autocomplete").html("<ul class='autocomplete'>"+str+"</ul>");
				auto.selectRow();
			});
}

function selectValue(eid)
{
	arr = auto.getValue();
	$("#"+eid).val(arr[0]);
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=id&val="+arr[2]+"&operator=", 
			function(data) 
			{
				
				ar = eid.split("-");
				pos = ar[1];
				for( i in data.nguyenlieus)
				{
					
					$("#tennguyenlieu-"+pos).val(data.nguyenlieus[i].tennguyenlieu);
					$("#manguyenlieu-"+pos).val(data.nguyenlieus[i].manguyenlieu);
					$("#madonvi-"+pos).val(data.nguyenlieus[i].madonvi);
				}
				
			});
	auto.closeAutocomplete()
}

</script>
