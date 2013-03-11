				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%">
                        	
                        	<input id="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                           
                        </th>
                        <th>STT</th>
                        <th>Mã nguyên vật liệu</th>
                        <th>
                        	Tên nguyên vật liệu
                            <a href="#down"><img src="<?php echo DIR_IMAGE?>icon/sortup.png"></a>
                        </th>
                        
                        <th>Loại</th>
                        <th>Kho</th>
                        
                        <th>Số lượng tồn</th>
                        <th>Tồn tối thiểu</th>
                        <th>Tồn tối đa</th>
                        <th>Số lượng 1 lần đặt hàng</th>
                        <th>Đơn vị tính</th>
                        
                        <th>Mục đích sử dụng</th>
                        <th>Ghi chú</th>
                        <th>Hình</th>
                        <?php if($dialog!=true){ ?>
                        <th>Control</th>     
                        <?php } ?>
                    </tr>
                </thead>
                <tbody>
        
        
        <?php
            foreach($datas as $key => $item)
            {
        ?>
                    <tr>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['manguyenlieu']?></td>
                        <td><?php echo $item['tennguyenlieu']?></td>
                        
                        <td><?php echo $item['tenloai']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        
                		<td class="number">
                        	<?php if($item['soluongton'] >0){?>
                            <a onclick="viewTonKho(<?php echo $item['id']?>)"><?php echo $this->string->numberFormate($item['soluongton'],0)?></a>
                            <?php }else{?>
                        	<?php echo $this->string->numberFormate($item['soluongton'],0)?>
                            <?php } ?>
                        </td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoithieu'],0)?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoida'],0)?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['soluongmoilandathang'],0)?></td>
                        <td><?php echo $item['madonvi']?></td>
                        
                        <td><?php echo $item['mucdichsudung']?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <!--<input type="button" class="button" name="btnDinhLuong" value="<?php echo $item['text_dinhluong']?>" onclick="window.location='<?php echo $item['link_dinhluong']?>'"/>-->
                            <!--<input type="button" class="button" name="btnCapNhatGia" value="<?php echo $item['text_capnhatgia']?>" onclick="window.location='<?php echo $item['link_capnhatgia']?>'"/>-->
                           	<input type="button" class="button" name="btnXemGia" value="<?php echo $item['text_xemgia']?>" onclick="window.location='<?php echo $item['link_xemgia']?>'"/>
                        </td>
                        <?php } ?>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
                <?php echo $pager?>
<script language="javascript">
$('#inputchk').click(function(e) {
	var chk=this.checked;
    $('.inputchk').each(function(index, element) {
        this.checked = chk;
    });
});
</script>