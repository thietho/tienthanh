				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($dialog!=true){ ?>
                        <th width="1%">
                        	
                        	<input id="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                           
                        </th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Mã nguyên vật liệu</th>
                        <th>
                        	Tên nguyên vật liệu
                        </th>
                        <?php if($dialog!=true){ ?>
                        <th>Loại</th>
                        <th>Kho</th>
                        
                        <th>Số lượng tồn</th>
                        <th>Tồn tối thiểu</th>
                        <th>Tồn tối đa</th>
                        <th>Số lượng 1 lần đặt hàng</th>
                        <?php } ?>
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
                    <tr class="item" id="<?php echo $item['id']?>" manguyenlieu="<?php echo $item['manguyenlieu']?>" tennguyenlieu="<?php echo $item['tennguyenlieu']?>">
                    	<?php if($dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['manguyenlieu']?></td>
                        <td><?php echo $item['tennguyenlieu']?></td>
                        <?php if($dialog!=true){ ?>
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
                        <?php } ?>
                        <td><?php echo $this->document->getDonViTinh($item['madonvi'])?></td>
                        
                        <td><?php echo $item['mucdichsudung']?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/nguyenlieu/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                            <!--<input type="button" class="button" name="btnDinhLuong" value="<?php echo $item['text_dinhluong']?>" onclick="window.location='<?php echo $item['link_dinhluong']?>'"/>-->
                            <!--<input type="button" class="button" name="btnCapNhatGia" value="<?php echo $item['text_capnhatgia']?>" onclick="window.location='<?php echo $item['link_capnhatgia']?>'"/>-->
                            <?php if($this->user->checkPermission("quanlykho/nguyenlieu/xemgia")==true){ ?>
                           	<input type="button" class="button" name="btnXemGia" value="<?php echo $item['text_xemgia']?>" onclick="window.location='<?php echo $item['link_xemgia']?>'"/>
                            <?php } ?>
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
<?php if($dialog){ ?>
<script language="javascript">
$('.item').click(function(e) {
	var html = "<div class='selectitem' id='"+ $(this).attr('id') +"'>"+ $(this).attr('tennguyenlieu') +"   <a class='removeitem'>X</a></div>";
    $('#popup-seletetion').append(html);
	
	$('.removeitem').click(function(e) {
		$(this).parent().remove();
	});
});

</script>
<?php } ?>