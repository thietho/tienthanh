<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>

<div class="section" id="sitemaplist">

	<div class="section-title">Phiếu xuất nguyên vật liệu</div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save()"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieuxuatnguyenlieu')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                	<li class="tabs-selected"><a href="#fragment-phieuxuatnguyenlieu"><span>Thông tin phiếu xuất nguyên vật liệu </span></a></li>
                    <li class="tabs"><a href="#fragment-chitietphieuxuatnguyenlieu"><span>Chi tiết phiếu xuất nguyên vật liệu</span></a></li>
                </ul>
                
                <div id="fragment-phieuxuatnguyenlieu" class="tabs-container">   
                	<?php if($item['maphieu']!=""){ ?>
                    <p>
                        <label>Số chứng từ</label><br />
                        <input type="hidden" name="maphieu" value="<?php echo $item['maphieu']?>" class="text" size=60  />
                        <?php echo $item['maphieu']?>
                    </p>
                    <?php } ?>
                    <p>
                        <label>Người nhận</label><br/>
                        <input id="nguoinhan" type="text" name="nguoinhan" value="<?php echo $item['nguoinhan'] ?>" class="text" size="60" />
                    </p>   
                    <p>
                        <label>Loại xuất</label><br/>
                        <select id="loainguon" name="loainguon">
                            <?php foreach($this->document->loainguonxuat as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                        
                    </p>
                   
                    <p>
                    	<label>Xuất từ kho</label><br/>
                        <input id="makho" type="hidden" name="makho" value="<?php echo $item['makho'] ?>" class="text" size="60" />
                        <input id="tenkho" type="text" name="tenkho" value="<?php echo $item['tenkho'] ?>" class="text" size="60" readonly />
                        <input type="button" class="button" name="btnChonKho" value="Chọn kho" onClick="selectKho()">
                    	<input type="button" class="button" name="btnChonKho" value="Bỏ chọn" onClick="unSelectKho()"> 
                    </p>
                    <!--<p id="rowkho">
                    	<label>Xuất thẳng đến kho</label><br/>
                        <input id="makho" type="hidden" name="makho" value="<?php echo $item['makho'] ?>" class="text" size="60" />
                        <input id="tenkho" type="text" name="tenkho" value="<?php echo $item['tenkho'] ?>" class="text" size="60" readonly />
                        <input type="button" class="button" name="btnChonKho" value="Chọn kho" onClick="selectKho()">
                    	<input type="button" class="button" name="btnChonKho" value="Bỏ chọn" onClick="unSelectKho()"> 
                    </p>
                    <p id="rowcongdoan" style="display:none">
                    	<label>Xuất cho công đoạn</label><br/>
                        <label>Chọn linh kiện</label>
                        <select id="malinhkien" name="malinhkien"  onChange="changelinhkien()">
                            <option value=""></option>
                            <?php foreach($linhkien as $val){ ?>
                            <option value="<?php echo $val['id']?>"><?php echo $val['tenlinhkien'] ?></option>
                            <?php } ?>
                        </select>
                        <label>Chọn công đoạn</label>
                        <select id="macongdoan" name="macongdoan">
                           
                        </select>
                    </p>-->
                    
                    <!--<p>
                        <label>Ngày xuất</label><br />
                        <script language="javascript">
                            $(function() {
                                $("#ngayxuat").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                         <input type="text" id="ngayxuat" name="ngayxuat" value="<?php echo $this->date->formatMySQLDate($item['ngayxuat'])?>" class="text" size=60 />
                    </p>-->
                    
                    <p>
                        <label>Mã hợp đồng</label><br />
                        <input type="text" name="mahopdong" value="<?php echo $item['mahopdong']?>" class="text" size=60 />
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
                        <label>Nhân viên lập phiếu</label><br/>
                        <input type="hidden" name="nguoilap" value="<?php echo $item['nguoilap'] ?>" class="text" size=60 />
                        <input type="text" name="tennguoilap" value="<?php echo $item['tennguoilap'] ?>" readonly class="text" size=60 />
                    </p>
                    
                    <!--<p>
                        <label>Tình trạng phiếu</label><br/>
                        <select id="tinhtrang" name="tinhtrang">
                           
                            <?php foreach($this->document->thanhtoan as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val ?></option>
                            <?php } ?>
                        </select>
                    </p>-->
                    <input type="hidden" name="tinhtrang" value="chuathanhtoan" />
                    <p>
                        <label>Lệnh xuất</label><br />
                        <input type="text" name="lenhxuat" value="<?php echo $item['lenhxuat']?>" class="text" size=60 />
                    </p>
                    <p>
                        <label>Lý do xuất</label><br />
                        <textarea id="lydoxuat" name="lydoxuat"><?php echo $item['lydoxuat']?></textarea>
            		</p>
                  	<p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
            		</p>
                </div>
                
                <!-- chi tiet phieu xuat nguyen lieu -->
                <div id="fragment-chitietphieuxuatnguyenlieu" class="tabs-container">
                	
                    <p>
                        <label>Chi tiết phiếu xuất nguyên vật liệu</label>
                        <p>
                            <table style="width:auto">
                                <thead>
                                    <tr>
                                        <th>Mã nguyên vật liệu</th>
                                        <th>Tên nguyên vật liệu</th>
                                        <th>Tem</th>
                                        <th>Số lượng</th>
                                        <th>Thực nhập</th>
                                        <th>Bao bì</th>
                                        <th>Đơn vị tính</th>
                                        <th>Đơn giá</th>
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
<script src="<?php echo DIR_JS?>jquery.tabs.pack.js" type="text/javascript"></script>
<script language="javascript">
var auto = new AutoComplete();
var index = 0;
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieuxuatnguyenlieu/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/phieuxuatnguyenlieu";
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

function changeloaiphieu()
{
	var str = $("#loaiphieu").val();
	$("#makho").val("");
	$("#tenkho").val("");
	$("#malinhkien").val("");
	$("#macongdoan").val("");
		
	if(str == 'xt')
	{
		$("#rowkho").attr("style","display:''");
		$("#rowcongdoan").attr("style","display:none");
	}
	else
	{
		$("#rowkho").attr("style","display:none");
		$("#rowcongdoan").attr("style","display:''");
	}
	
}

function changelinhkien()
{
	var malinhkien = $("#malinhkien").val();
	
	$("#macongdoan").html("");
	
	$.getJSON("?route=quanlykho/congdoan/getCongDoan&col=malinhkien&val="+malinhkien, 
	function(data) 
	{
		var row = "<option value=''></option>";
		for( i in data.congdoans)
		{
			row += "<option value='" + data.congdoans[i].id + "'>" + data.congdoans[i]['tencongdoan'] + "</option>";
		}
		
		$("#macongdoan").append(row);
		
	});
}

$("#malinhkien").val("<?php echo $item['malinhkien']?>");
$("#macongdoan").val("<?php echo $item['macongdoan']?>");
$("#tinhtrang").val("<?php echo $item['tinhtrang']?>");

//bat dau javascript cho chi tiet

<?php 
	$index = 0;
	
	if(count($chitiet))
	{
		foreach($chitiet as $val)
		{ 
	?>
			
			createRow(	"<?php echo $val['id']?>",
						"<?php echo $val['itemid']?>",
						"<?php echo $this->document->getNguyenLieu($val['itemid'],'manguyenlieu')?>",
						"<?php echo $val['itemname']?>",
						"<?php echo $val['soluong']?>",
						"<?php echo $val['dongia']?>",
						"<?php echo $val['madonvi']?>",
						"<?php echo $val['thucnhap']?>",
						"<?php echo $val['baobi']?>",
						"<?php echo $val['ghichu']?>"
					);
	<?php
			$index += 1;
		} 
	}
?>

function selectNguyenLieu()
{
	$('#manguyenlieu').val('');
	
	openDialog("?route=quanlykho/nguyenlieu&opendialog=true",1000,800);
	
	list = trim($("#manguyenlieu").val(), ',');
	arr = list.split(",");
	
	for(i in arr)
	{
		
		createRow(0,arr[i],"",0, 0, "", 0);
	}
	
}


function newRow()
{
	createRow("","","","", 0, 0, "", 0,0, "");
}
function createRow(id, manguyenlieu,manguyenlieutext, tennguyenlieu,  soluong, dongia, madonvi,  thucnhap,baobi, ghichu)
{
	
	var cellid = '<input type="hidden" id="chitiet-'+index+'" name="chitiet['+index+']" value="' +id+ '">';
	var cellitemid = '<input type="hidden" id="itemid-'+ index +'" name="itemid['+index+']" value="' + manguyenlieu + '">';
	
	cellmanguyenlieu = '<input type="text" class="text gridautocomplete" size=10 id="manguyenlieutext-'+ index +'" name="manguyenlieutext['+index+']" value="' + manguyenlieutext + '">';
	
	var celltennguyenlieu = '<input type="text" id="tennguyenlieu-'+index+'" name="tennguyenlieu['+index+']" size=10 value="' + tennguyenlieu + '" readonly>';
	var celltem = "<select id='tem-" + index + "' name='tem[" + index + "]' onchange='selectTem(this.value,"+index+")'>"
						+ "</select>";
	var cellsoluong = '<input type="text" id="soluong-'+index+'" name="soluong['+index+']" value="'+soluong+'" class="number" size=5 />';
	var celldongia = '<input type="text" id="dongia-'+index+'" name="dongia['+index+']" value="'+dongia+'" class="number" size=5 />';
	var cellmadonvi = "<select id='madonvi-" + index + "' name='madonvi[" + index + "]' disabled>" 
						+ "<?php foreach($donvitinh as $val){ ?>"
						+ "<option value='<?php echo $val['madonvi']; ?>'><?php echo $val['tendonvitinh'] ?></option><?php } ?>"
						+ "</select>";		
	
	
	var cellthucnhap = '<input type="text" id="thucnhap-'+index+'" name="thucnhap['+index+']" value="'+thucnhap+'" class="number" size=5 />';
	var cellbaobi = '<input type="text" id="baobi-'+index+'" name="baobi['+index+']" value="'+baobi+'" class="number" size=5 />';
	var cellghichu ='<textarea id="ghichuchitiet-'+index+'" name="ghichuchitiet[' + index + ']" class="ben-grid" readonly>'+ghichu+'</textarea>';
	var row ="";
	row+='						<tr id="row'+index+'">';
	row+='                          <td>'+cellid+cellitemid+cellmanguyenlieu+'</td>';
	row+='                          <td>'+celltennguyenlieu+'</td>';
	row+='                          <td>'+celltem+'</td>';
	row+='                          <td>'+cellsoluong+'</td>';
	row+='                          <td>'+cellthucnhap+'</td>';
	row+='                          <td>'+cellbaobi+'</td>';
	row+='                          <td>'+cellmadonvi+'</td>';
	row+='                          <td>'+celldongia+'</td>';
	
	row+='                          <td>'+cellghichu+'</td>';
	row+='                          <td><input type="button" class="button" value="Xóa" onclick="removeRow('+index+',\''+id+'\')"></td>';
	
	row+='                      </tr>';
	
	$("#chitiet").append(row);
	if(madonvi == "")
		$("#madonvi-"+index+"").val(madonvi);
	else
		$("#madonvi-"+index+"").val(madonvi);
	if(dongia == 0)
		$("#dongia-"+index+"").val(dongia);
	getTems("itemid",manguyenlieu,index);
	index++;
	numberReady();
	auto.autocomplete();
}

function removeRow(pos,id)
{
	$("#delchitiet").val($("#delchitiet").val()+","+id);
	$("#row"+pos).remove();
}

function fillDataRow(val,id,pos)
{
	$.getJSON("?route=quanlykho/nguyenlieu/getNguyenLieu&col=id&val="+id, 
	function(data) 
	{
		$("#soluong-"+pos).val(val);	
	});
	
	
}
//end javascript cho chi tiet


//chon kho
function getKho(col,val,operator)
{
	$.getJSON("?route=quanlykho/kho/getKho&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.khos)
				{
					$("#makho").val(data.khos[i].makho);
					$("#tenkho").val(data.khos[i].tenkho);
				}
			});
}

function selectKho()
{
	openDialog("?route=quanlykho/kho&opendialog=true",1000,800);
	
	list = trim($("#makho").val(), ',');
	arr = list.split(",");
	makho = arr[0];
	getKho("makho",makho,'');
}

function unSelectKho()
{
	if($("#tenkho").val().length > 0)
	{
		$("#makho").val("");
		$("#tenkho").val("");
	}
}
//end chon kho
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
					$("#itemid-"+pos).val(data.nguyenlieus[i].id);
					$("#madonvi-"+pos).val(data.nguyenlieus[i].madonvi);
					getTems("itemid",data.nguyenlieus[i].id,pos);
				}
				
			});
	auto.closeAutocomplete()
}

function getTems(col,val,pos)
{
	$.getJSON("?route=quanlykho/phieunhapxuat/getTonKho&makho="+$("#makho").val()+"&col="+col+"&val="+val+"&operator=", 
			function(data) 
			{
				var str = '<option value=""></option>';
				for( i in data.chitietphieunhapxuats)
				{
					str += '<option value="'+ data.chitietphieunhapxuats[i].id +'">'+data.chitietphieunhapxuats[i].id+'</option>';
				}
				$("#tem-"+pos).html(str);
			});
}

function selectTem(temid,pos)
{
	if(temid!="")
	{
		$.getJSON("?route=quanlykho/phieunhapxuat/getTonKho&col=id&val="+temid+"&operator=", 
				function(data) 
				{
					for( i in data.chitietphieunhapxuats)
					{
						$("#chitiet-"+pos).val(data.chitietphieunhapxuats[i].id);
						$("#soluong-"+pos).val(data.chitietphieunhapxuats[i].soluong);
						$("#thucnhap-"+pos).val(data.chitietphieunhapxuats[i].thucnhap);
						$("#baobi-"+pos).val(data.chitietphieunhapxuats[i].baobi);
						$("#madonvi-"+pos).val(data.chitietphieunhapxuats[i].madonvi);
						$("#dongia-"+pos).val(data.chitietphieunhapxuats[i].dongia);
						$("#ghichuchitiet-"+pos).val(data.chitietphieunhapxuats[i].ghichu);
					}
					numberReady();
				});
		
	}
	else
	{
		$("#chitiet-"+pos).val("");
		$("#soluong-"+pos).val(0);
		$("#thucnhap-"+pos).val(0);
		$("#baobi-"+pos).val(0);
		//$("#madonvi-"+pos).val("");
		$("#dongia-"+pos).val(0);
		$("#ghichuchitiet-"+pos).val("");
	}
}

</script>