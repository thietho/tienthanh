				<?php echo $pager?>
                <table class="data-table" cellpadding="0" cellspacing="0">
                <thead>
                    <tr class="tr-head">
                        <th width="1%">
                        <?php if($dialog==false){ ?>
                        <input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);">
                        <?php } ?>
                        </th>
                        
                        <th>STT</th>
                        <th>Mã khách hàng</th>
                        <th>Họ tên</th>
                        <th>Địa chỉ</th>
                        <th>Khu vực</th>
                        
                        <th>Điện thoại</th>
                        <th>Fax</th>
                        <th>Người đại diện</th>
                        <th>Loại khách hàng</th>
                        <th>Control</th>                                  
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
                        <td><?php echo $item['makhachhang']?></td>
                        <td><?php echo $item['hoten']?></td>
                        <td><?php echo $item['diachi']?></td>
                        <td><?php echo $this->document->getTenNhom($item['khuvuc'])?></td>
                        <td><?php echo $item['dienthoai']?></td>
                        <td><?php echo $item['fax']?></td>
                        <td><?php echo $item['nguoidaidien'] ?></td>
                        <td><?php echo $this->document->getTenNhom($item['loaikhachhang']) ?></td>
                        <td class="link-control">
                        	<?php if($this->user->checkPermission("quanlykho/khachhang/update")==true){ ?>
                        	<input type="button" class="button" name="btnEdit" value="<?php echo $item['text_edit']?>" onclick="window.location='<?php echo $item['link_edit']?>'"/>
                            <?php } ?>
                        </td>
                    </tr>
        <?php
            }
        ?>
                        
                                                    
                </tbody>
                </table>
                <?php echo $pager?>