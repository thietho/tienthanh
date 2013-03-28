<div class="section" id="sitemaplist">
	<div class="section-title"><?php echo $this->document->title?></div>
	<div>Quá trinh thay đổi sản phẩm <?php echo $logsanpham[0]->masanpham?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	
            <div class="clearer">^&nbsp;</div>
        	
        	<div>
               	<?php 
                if(count($logdinhluong))
                foreach($logdinhluong as $item){ ?>
                <div>
                    <label>Ngày: <?php echo $this->date->formatMySQLDate($item['logdate'],"longdate")?></label>
                    <table style="width:auto">
                    	<thead>
                            <tr>
                                <th>Tên linh kiện</th>
                                <th>Số lượng</th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php foreach($item as $val){ ?>
                            <tr>
                                <td><?php echo $this->document->getLinhKien($val->malinhkien)?></td>
                                <td class="number"><?php echo $val->soluong?></td>
                            </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                </div>
                <?php } ?>
                <table>
                	<thead>
                		<tr>
                        	<th>Mã vạch</th>
                            <th>Tên sản phẩm</th>
                            <th>Nhóm</th>
                            <th>Loại</th>
                            <th>Kho</th>
                            <th>Đơn vị tính</th>
                            <th>Đơn giá bán</th>
                            <th>Đóng gói</th>
                            <th>Khu vực</th>
                            <th>Phân cấp</th>
                            <th>Hiện hành</th>
                            <th>Ghi chú</th>
                            <th></th>
                    	</tr>
                    </thead>
                    <tbody id="listsanpham">
                    	<?php foreach($logsanpham as $item){ ?>
                        <tr>
                        	<td><?php echo $item->mavach?></td>
                            <td><?php echo $item->tensanpham?></td>
                            <td><?php echo $this->document->getTenNhom($item->manhom)?></td>
                            <td><?php echo $this->document->getTenNhom($item->loai)?></td>
                            <td><?php echo $this->document->getTenNhom($item->makho)?></td>
                            <td><?php echo $this->document->getTenDonVi($item->madonvi)?></td>
                            <td class="number"><?php echo $item->dongiabancai?></td>
                            <td class="number"><?php echo $item->donggoi?></td>
                            <td class="number"><?php echo $item->khuvuc?></td>
                            <td class="number"><?php echo $item->phancap?></td>
                            <td class="number"><?php echo $this->document->hienhanh[$item->hienhanh]?></td>
                            <td><?php echo $item->ghichu?></td>
                            <td><?php echo $this->date->formatMySQLDate($item->logdate,"longdate")?></td>
                    	</tr>
                        <?php } ?>
                    </tbody>
                </table>
                
               	
                
                <?php
                	$arrgia = array();
                    $arrtime = array();
                    $max = 0;
                    $arry = array();
                    
                    foreach($logsanpham as $item)
                    {
                    
                    	
                    	//$arry[] = $this->string->toNumber($item->dongiabancai);
                    	if($this->string->toNumber($item->dongiabancai) > $max)
                        {
                        	$max = $this->string->toNumber($item->dongiabancai);
                        }
                    }
                    echo $max;
                	foreach($logsanpham as $item)
                    {
                    	$arrgia[] =  $this->string->toNumber($item->dongiabancai)*100/$max;
                        $arrtime[] = $this->date->formatMySQLDate($item->logdate);
                    }
                   	//sort($arry);
                    $arry[] =0 ;
                   	for($i=1;$i<=10;$i++)
                    {
                    	$arry[] = ($i)*$max/10;
                    }
                    //print_r($arry);
                	$url = "http://chart.apis.google.com/chart?cht=bvg";
                    $url .= "&cht=bvg";
                    $url .= "&chtt=";
                    $url .= "&chts=FF0000,18";
                    $url .= "&chd=t:" . implode(",",$arrgia);
                    $url .= "&chs=500x300";
                    $url .= "&chco=4D89F9&chxt=x,y";
                    $url .= "&chxl=0:|".implode("|",$arrtime)."|1:|".implode("|",$arry);
                    $url .= "&chbh=r,2,0.5";
                    
                ?>
                <img src="<?php echo $url?>" />
                
            </div>
           	
        </form>
    
    </div>
    
</div>