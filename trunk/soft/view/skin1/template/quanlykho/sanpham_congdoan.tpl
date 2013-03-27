<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	
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
               	
            </div>
            <?php foreach($dinhluong as $item){ ?>
            <div>
            	<label>Mã linh kiện: <?php echo $item['tenlinhkien']?></label>
            	<table>
                	<thead>
                		<tr>
                        	<th>Mã công đoạn</th>
                            <th>Tên công đoạn</th>
                            <th>Thứ tự công đoạn</th>
                            <th>Nguyên liệu sản xuất</th>
                            <th>Thiết bị sản xuất</th>
                            <th>Định mức chỉ tiêu</th>
                            <th>Giá gia công</th>
                            <th>Định mức phế liệu</th>
                            <th>Định mức phế phẩm</th>
                            <th>Định mức hao hụt</th>
                            <th>Định mức năng xuất</th>
                            <th>Định mức phụ liệu</th>
                            <th>Số lượng/Kg</th>
                            <th>Ghi chú</th>
                            <th></th>
                    	</tr>
                    </thead>
                    <tbody id="listcongdoan-<?php echo $item['malinhkien']?>">
                    	
                    </tbody>
                </table>
            </div>
            <?php } ?>
        </form>
    
    </div>
    
</div>
<script language="javascript">
//Cong doan
$(document).ready(function() {
	<?php foreach($dinhluong as $item){ ?>
	getCongDoan("listcongdoan-<?php echo $item['malinhkien']?>","malinhkien","<?php echo $item['malinhkien']?>","")
	<?php } ?>
});

function getCongDoan(eid,col,val,operator)
{
	$.getJSON("?route=quanlykho/congdoan/getCongDoan&col="+col+"&val="+val+"&operator="+operator, 
			function(data) 
			{
				//var str = '<option value=""></option>';
				for( i in data.congdoans)
				{
					
					$("#"+eid).append(createRowCongDoan(data.congdoans[i]));
					
				}
				
			});
}

function createRowCongDoan(obj)
{
	
	var btnXemQuaTrinh = '<input type="button" value="Xem quá trình biến đổi" class="button" onClick="viewCongDoan(\''+obj.macongdoan+'\')"/>';
	var row = '';
	row+='					<tr>';
    row+='                    	<td>'+obj.macongdoan+'</td>';
    row+='                      <td>'+obj.tencongdoan+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.thututhuchien)+'</td>';
    row+='                      <td>'+obj.tennguyenlieusanxuat+'</td>';
    row+='                      <td>'+obj.tenthietbisanxuatchinh+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.dinhmucchitieu)+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.giagiacong)+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.dinhmucphelieu)+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.dinhmucphepham)+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.dinhmuchaohut)+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.dinhmucnangxuat)+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.dinhmucphulieu)+'</td>';
    row+='                      <td class="number">'+formateNumber(obj.soluongtrenkg)+'</td>';
    row+='                      <td>'+obj.ghichu+'</td>';
    row+='                      <td>'+btnXemQuaTrinh+'</td>';
    row+='                  </tr>';
	return row
}

function viewCongDoan(macongdoan)
{
	
	openDialog("?route=quanlykho/congdoan/viewCongDoan&macongdoan="+macongdoan,1000,800);
}
</script>
