                <?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%">
                        	<?php if($dialog!=true){ ?>
                        	<input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                            <?php } ?>
                        </th>
                        <th>STT</th>
                        <th>Mã tài sản</th>
                        <th>Tên tài sản</th>
                        <th>Số sêri</th>
                        <th>Nhóm</th>
                        <th>Loại</th>
                        <th>Kho</th>
                        <th>Khấu hao</th>
                        <th>Đơn vị tính</th>
                        <th>Ngày mua</th>
                        <th>Phòng ban nhận</th>
                        <th>Người mượn gần nhất</th>
                        <th>Đơn giá</th>
                        <th>Tinh trang</th>
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
                    <tr class="item" id="<?php echo $item['id']?>" mataisan="<?php echo $item['mataisan']?>" tentaisan="<?php echo $item['tentaisan']?>" <?php echo ($item["dachomuon"]==true)?"":'style="background:#CCC"' ;?> madonvi="<?php echo $item['madonvi']?>" tendonvi="<?php echo $this->document->getDonViTinh($item['madonvi'])?>">
                        <td class="check-column">
                        	
                            <input class="inputchk" type="checkbox" name="delete[<?php echo $item['id']?>]" value="<?php echo $item['id']?>" <?php echo ($item["dachomuon"]==true)?"":'disabled="disabled"' ;?>>		
                            
                        </td>
                        <td><?php echo $key+1 ?></td>
                        <td><?php echo $item['mataisan']?></td>
                        <td><?php echo $item['tentaisan']?></td>
                        <td><?php echo $item['soseri']?></td>
                        <td><?php echo $item['tennhom']?></td>
                        <td><?php echo $item['tenloai']?></td>
                        <td><?php echo $item['tenkho']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['khauhao'],0)?> tháng</td>
                		<td><?php echo $item['madonvi']?></td>
                        <td><?php echo $this->date->formatMySQLDate($item['ngaymua'])?></td>
                        <td><?php echo $this->document->getNhom($item['phongbannhan'])?></td>
                        <td><?php echo $item['tennguoinhan']?></td>
                        <td class="number"><?php echo $this->string->numberFormate($item['dongia'],0)?></td>
                        <td><?php echo ($item["dachomuon"]==true)?"":"Đã cho mượn" ;?></td>
                        <td><?php echo $item['mucdichsudung']?></td>
                        <td><?php echo $item['ghichu']?></td>
                        <td><img src="<?php echo $item['imagethumbnail']?>" /></td>
                        <?php if($dialog!=true){ ?>
                        <td class="link-control">
                            <?php if($this->user->checkPermission("quanlykho/taisan/update")==true){ ?>
                            <input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("quanlykho/taisan/lichsu")==true){ ?>
                            <input type="button" class="button" name="btnHistory" value="<?php echo $item['text_history']?>" onclick="window.location='<?php echo $item['link_historry']?>'"/>
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
	intSelectTaiSan()
</script>
<?php } ?>