

<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieuthuthap')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                	<li class="tabs-selected"><a href="#fragment-phieuthuthap"><span>Thông tin phiếu thu thập</span></a></li>
                    <li class="tabs"><a href="#fragment-chitietphieuthuthap"><span>Chi tiết phiếu thu thập</span></a></li>
                </ul>
    
                <div id="fragment-phieuthuthap" class="tabs-container">   
                    <?php if($item['maphieu']!=""){ ?>
                    <p>
                        <label>Số chứng từ</label><br />
                        <input type="hidden" name="maphieu" value="<?php echo $item['maphieu']?>" class="text" size=60  />
                        <?php echo $item['maphieu']?>
                    </p>
                    <?php } ?>
                    <p>
                        <label>Công đoạn</label><br/>
                        <input id="macongdoan" type="hidden" class="text" name="macongdoan" value="<?php echo $item['macongdoan'] ?>" />
                        <input id="macongdoantext" type="text" class="text gridautocomplete" name="macongdoantext" value="" />
                        <label id="tencongdoan"></label>
                        
                    </p>   
                    
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
                         <input type="text" id="ngay" name="ngay" value="<?php echo $this->date->formatMySQLDate($item['ngay'])?>" class="text" size=60 />
                    </p>
                    
                    
                   	
                    
                    <p>
                        <label>Ca</label><br />
                        <input type="text" name="ca" value="<?php echo $item['ca']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Máy</label><br />
                        <input type="text" name="may" value="<?php echo $item['may']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Ngày lập phiếu</label><br />
                        <script language="javascript">
                            $(function() {
                                $("#ngaylapphieu").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                         <input type="text" id="ngaylapphieu" name="ngaylapphieu" value="<?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?>" class="text" size=60 />
                    </p>
                    
                    
                    <p>
                        <label>Nhân viên sản xuất</label><br/>
                        
                        <input type="hidden" id="selectnhanvien" class="text" size=60 />
                        <input type="hidden" id="nhanviensanxuat" name="nhanviensanxuat" value="<?php echo $item['nhanviensanxuat'] ?>" class="text" size=60 />
                        <label id="tennhanviensanxuat"><?php echo $item['tennhanviensanxuat'] ?></label>
                        <input type="button" class="button" name="btnSelectNhanVien" value="Chọn nhân viên" onClick="selectNhanVien()">
                    </p>
					<p>
                        <label>Số lượng sản xuất</label><br />
                        <input type="text" name="soluongsanxuat" value="<?php echo $item['soluongsanxuat']?>" class="text number" size=60 />
                    </p>
                  	<p>
                    	<label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu'] ?></textarea>
                    </p>
                </div>
                
                <!-- chi tiet phieu nhap nguyen lieu -->
                <div id="fragment-chitietphieuthuthap" class="tabs-container">
                	
                    <p>
                        
                        <p>
                            <input type="hidden" id="manguyenlieu" name="manguyenlieu">
                            <table style="width:auto">
                                <thead>
                                    <tr>
                                        <th>Giờ</th>
                                        <th>Thành phẩm</th>
                                        <th>Phế liệu</th>
                                        <th>Phế phẩm</th>
                                        <th>Hao hụt</th>
                                        <th>Ghi chú</th>
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
<div id="autocomplete" style="display:none;position:absolute;background:#FFF;"></div>

<script language="javascript">
var auto = new AutoComplete();
var index = 0;
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieuthuthap/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/phieuthuthap";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}



function selectNhanVien()
{
	openDialog("?route=quanlykho/nhanvien&opendialog=true",1000,800);
	
	list = trim($("#selectnhanvien").val(), ',');
	arr = list.split(",");
	var manhanvien = arr[0];
	getNhanVien(manhanvien);
}

function getNhanVien(manhanvien)
{
	$.getJSON("?route=quanlykho/nhanvien/getNhanVien&col=id&val="+manhanvien, 
	function(data) 
	{
		for( i in data.nhanviens)
		{
			$("#nhanviensanxuat").val(data.nhanviens[i].id);
			$("#tennhanviensanxuat").html(data.nhanviens[i].hoten);
		}
	});	
}

$(document).ready(function() {
	if($("#id").val()!="")
	{
		auto.selectValue("macongdoan");
		getNhanVien($("#nhanviensanxuat").val());
	}
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	auto.autocomplete();
});
//bat dau javascript cho chi tiet

<?php 
	$index = 0;
	
	if(count($chitiet))
	{
		foreach($chitiet as $val)
		{ 
	?>
			createRow(	"<?php echo $val['id']?>",
						"<?php echo $this->date->formatTime($val['gio'])?>",
						"<?php echo $val['thanhpham']?>",
						"<?php echo $val['phelieu']?>",
						"<?php echo $val['phepham']?>",
						"<?php echo $val['haohut']?>",
						"<?php echo $val['ghichu']?>"
					);
	<?php
			$index += 1;
		} 
	}
?>




function newRow()
{
	createRow(0,"",0,0,0,0,"");
}
function createRow(id, gio,thanhpham, phelieu,  phepham, haohut, ghichu)
{
	
	var cellid = '<input type="hidden" name="chitiet['+index+']" value="' +id+ '">';
	
	var cellgio = '<input type="text" name="gio['+index+']" value="'+gio+'" class="text" size=5 />';
	var cellthanhpham = '<input type="text" name="thanhpham['+index+']" value="'+thanhpham+'" class="text number" size=5 />';
	var cellphelieu = '<input type="text" name="phelieu['+index+']" value="'+phelieu+'" class="text number" size=5 />';
	
	var cellphepham = '<input type="text" name="phepham['+index+']" value="'+phepham+'" class="text number" size=5 />';
	var cellhaohut = '<input type="text" name="haohut['+index+']" value="'+haohut+'" class="text number" size=5 />';
	var cellghichu ='<textarea id="ghichuchitiet-'+index+'" name="ghichuchitiet[' + index + ']" class="ben-grid">'+ghichu+'</textarea>';
	var row ="";
	row+='						<tr id="row'+index+'">';
	row+='                          <td>'+cellid+cellgio+'</td>';
	row+='                          <td>'+cellthanhpham+'</td>';
	
	row+='                          <td>'+cellphelieu+'</td>';
	row+='                          <td>'+cellphepham+'</td>';
	row+='                          <td>'+cellhaohut+'</td>';
	
	row+='                          <td>'+cellghichu+'</td>';
	row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+',\''+id+'\')"></td>';
	
	row+='                      </tr>';
	
	$("#chitiet").append(row);
	
	
	index++;
	numberReady();
	
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
	
	this.loadData = function(col,val,operator)
	{
		$.getJSON("?route=quanlykho/congdoan/getCongDoan&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				str = "";
				for( i in data.congdoans)
				{
					str+= '<li id=rowauto-'+i+' class=autocompleterow>'+ data.congdoans[i].macongdoan + ':' +data.congdoans[i].tencongdoan+'</li><input type="hidden" id="idnguyenlieu-'+i+'" value="'+ data.congdoans[i].id +'" />';
				}
				$("#autocomplete").html("<ul class='autocomplete'>"+str+"</ul>");
				auto.selectRow();
			});
	}
	
	this.selectValue = function(eid)
	{
		arr = auto.getValue();
	
		$("#"+eid).val(arr[0]);
		macongdoan = arr[2];
		
		if(macongdoan == undefined)
			macongdoan = $("#"+eid).val();
		
		$.getJSON("?route=quanlykho/congdoan/getCongDoan&col=id&val="+macongdoan+"&operator=", 
				function(data) 
				{
					for( i in data.congdoans)
					{
						$("#macongdoan").val(data.congdoans[i].id);
						$("#macongdoantext").val(data.congdoans[i].macongdoan);
						$("#tencongdoan").html(data.congdoans[i].tencongdoan);
					}
					
				});
		auto.closeAutocomplete()
	}
	
	this.autocomplete = function()
	{
		$(".gridautocomplete").blur( function()
		{ 
			auto.selectValue(this.id);
		});
		
		$(".gridautocomplete").keyup(function(event)
		{
			//Press enter
			if (event.keyCode == '13')
			{
				auto.selectValue(this.id);
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
					
					auto.loadData("macongdoan",$(this).val(),"like")
					auto.curentRow = 0;
				}
				else
					auto.closeAutocomplete()
			}
		});
		
		
	};
	
	
	
}


</script>
