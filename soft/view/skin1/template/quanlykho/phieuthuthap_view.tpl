

<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="In" class="button" onClick="printPhieu('<?php echo $item['id']?>')"/>
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
                        <label>Số chứng từ</label>: <?php echo $item['maphieu']?>
                        <input type="hidden" name="maphieu" value="<?php echo $item['maphieu']?>" class="text" size=60  />
                        
                    </p>
                    <?php } ?>
                    <p>
                        <label>Công đoạn</label>:
                        <?php echo $this->document->getCongDoan($item['macongdoan'])?>
                        
                    </p>   
                    
                    <p>
                       
                        <label>Ngày</label>:
                        <?php echo $this->date->formatMySQLDate($item['ngay'])?>
                    </p>
                    
                    
                   	
                    
                    <p>
                        <label>Ca</label>:
                        <?php echo $item['ca']?>
                    </p>
                    <p>
                        <label>Máy</label>:
                        <?php echo $item['may']?>
                    </p>
                    <p>
                        <label>Ngày lập phiếu</label>:
                        <?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?>
                    </p>
                    
                    
                    <p>
                        <label>Nhân viên sản xuất</label>:
                        <?php echo $this->document->getNhanVien($item['nhanviensanxuat'])?>
                        
                    </p>
					<p>
                        <label>Số lượng sản xuất</label>:
                        <?php echo $item['soluongsanxuat']?>
                    </p>
                  	<p>
                    	<label>Ghi chú</label>:
                        <?php echo $item['ghichu'] ?>
                    </p>
                </div>
                
                <!-- chi tiet phieu nhap nguyen lieu -->
                <div id="fragment-chitietphieuthuthap" class="tabs-container">
                	
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
                                    </tr>
                                </thead>
                                <tbody id="chitiet">
                                    <?php 
                                    $sum['thanhpham'] = 0;
                                    $sum['phelieu'] = 0;
                                    $sum['phepham'] = 0;
                                    $sum['haohut'] = 0;
                                    
                                    foreach($chitiet as $key => $val)
                                    { 
                                    	$sum['thanhpham'] += $val['thanhpham'];
                                        $sum['phelieu'] += $val['phelieu'];
                                        $sum['phepham'] += $val['phepham'];
                                        $sum['haohut'] += $val['haohut'];
                                    ?>
                                    <tr>
                                    	<td><?php echo $this->date->formatTime($val['gio'])?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['thanhpham'],0)?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['phelieu'],0)?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['phepham'],0)?></td>
                                        <td class="number"><?php echo $this->string->numberFormate($val['haohut'],0)?></td>
                                        
                                        <td><?php echo $val['ghichu']?></td>
                                        
                                    </tr>
                                    <?php 
                                    } 
                                    ?>
                                </tbody>
                                <tfoot>
                                	<td></td>
                                    <td class="number"><?php echo $this->string->numberFormate($sum['thanhpham'],0)?></td>
                                    <td class="number"><?php echo $this->string->numberFormate($sum['phelieu'],0)?></td>
                                    <td class="number"><?php echo $this->string->numberFormate($sum['phepham'],0)?></td>
                                    <td class="number"><?php echo $this->string->numberFormate($sum['haohut'],0)?></td>
                                    <td></td>
                                </tfoot>
                            </table>
                            <input type="hidden" id="delchitiet" name="delchitiet" />
                    </p>
                
                </div>
                <!-- end chi tiet phieu nhan hang -->
                
            </div>
        </form>
    
    </div>
    
</div>


<script language="javascript">
function printPhieu(id)
{	
	openDialog("?route=quanlykho/phieuthuthap/view&id="+id+"&opendialog=true",1000,800);

}

$(document).ready(function() {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
});

</script>
