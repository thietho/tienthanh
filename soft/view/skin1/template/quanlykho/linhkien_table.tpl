				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                    	<?php if($dialog!=true){ ?>
                        <th width="1%">
                        	<?php if($dialog!=true){ ?>
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            <?php } ?>
                        </th>
                        <?php } ?>
                        <th>STT</th>
                        <th>Mã linh kiện</th>
                        <th>Tên linh kiện</th>
                        <th>Linh kiện /Lot</th>
                        <th>Số lượng tồn</th>
                        <th>Tồn tối thiểu</th>
                        <th>Tồn tối đa</th>
                        <th>Đơn vị tính</th>
                        <th>Tiền công</th>
                        <th>Kho</th>
                        <th>Định mức</th>
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
                    <tr class="item" id="<?php echo $item['id']?>" malinhkien="<?php echo $item['malinhkien']?>" tenlinhkien="<?php echo $item['tenlinhkien']?>"  madonvi="<?php echo $item['madonvi']?>" tendonvi="<?php echo $this->document->getDonViTinh($item['madonvi'])?>">
                    	<?php if($dialog!=true){ ?>
                        <td class="check-column"><input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" ></td>
                        <?php } ?>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['malinhkien']?></td>
                        <td><?php echo $item['tenlinhkien']?></td>
                        <td class="number"><?php echo $item['solinhkientrenlot']?></td>
                        <td class="number"><?php echo $item['soluongton']?></td>
                         <td class="number"><?php echo $this->string->numberFormate($item['tontoithieu'],0)?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tontoida'],0)?></td>
                        <td><?php echo $this->document->getDonViTinh($item['madonvi'])?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['tiencong'])?></td>
                		<td><?php echo $item['tenkho']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dinhmuc'])?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/linhkien/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="showLinhKienForm(<?php echo $item['id']?>)"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/linhkien/dinhluong")==true){ ?>
                            <input type="button" class="button" name="btnDinhLuong" value="<?php echo $item['text_dinhluong']?>" onclick="window.location='<?php echo $item['link_dinhluong']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/linhkien/caidatcongdoan")==true){ ?>
                            <input type="button" class="button" name="btnCapNhatGia" value="<?php echo $item['text_caidatcongdoan']?>" onclick="window.location='<?php echo $item['link_caidatcongdoan']?>'"/>
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
<?php if($dialog){ ?>
<script language="javascript">
	intSelectLinhKien()
</script>
<?php } ?>