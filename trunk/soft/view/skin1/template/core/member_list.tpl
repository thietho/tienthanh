<div class="section">

	<div class="section-title">Quản lý khách hàng</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="listmember" name="listmember">
        
        	<div class="button right">
               	<?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("core/member/insert")==true){ ?>
                <input type="button" class="button" value="Thêm" onclick="showMemberForm('','searchForm()')" />
                <?php } ?>
                <?php if($this->user->checkPermission("core/member/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteUser()"/>  
                <?php } ?>
                <?php } else { ?>
                <?php if($this->user->checkPermission("core/member/insert")==true){ ?>
                <input type="button" class="button" value="Thêm" onclick="showMemberForm('','searchForm()')" />
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            <div id="ben-search">
            	<p>
                    <label>Tên đăng nhập</label>
                    <input type="text" id="username" name="username" class="text"/>
                    
                    <label>Tên khách hàng</label>
                    <input type="text" id="fullname" name="fullname" class="text"/>
                    <label>Số diện thoai</label>
                    <input type="text" id="phone" name="phone" class="text"/>
                    <br />
                    <label>Địa chỉ</label>
                    <input type="text" id="address" name="address" class="text"/>
                    <label>Email</label>
                    <input type="text" id="email" name="email" class="text"/>
                
                
                
                    <label>Tình trạng</label>
                    <select id="status" name="status">
                        <option value=""></option>
                        <?php foreach($this->document->userstatus as $key => $val){ ?>
                        <option value="<?php echo $key?>"><?php echo $val?></option>
                        <?php } ?>
                    </select>
                
                </p>
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
            <div class="sitemap treeindex" id="memberlist">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
    viewAll();
	
});
$('#listmember .text').keyup(function(e) {
    searchForm();
});
$('#listmember select').change(function(e) {
    searchForm();
});

function activeUser(userid)
{
	$.ajax({
			url: "?route=core/member/active&id="+userid,
			cache: false,
			success: function(html){
			alert(html)
			loadData("?route=core/member/getList")
		  }
	});
}

function deleteUser()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=core/member/delete", 
				$("#listmember").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}
function loadData(url)
{
	$('#memberlist').html(loading);
	$('#memberlist').load(url);
}
function viewAll()
{
	var url = "?route=core/member/getList";


	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	loadData(url);
}
function searchForm()
{
	var url = "?route=core/member/getList";
	if($("#username").val() != "")
		url += "&username=" + encodeURI($("#username").val());
	if($("#fullname").val() != "")
		url += "&fullname="+ encodeURI($("#fullname").val());
	if($("#phone").val() != "")
		url += "&phone="+ encodeURI($("#phone").val());
	if($("#address").val() != "")
		url += "&address="+ encodeURI($("#address").val());
	if($("#email").val() != "")
		url += "&email="+ encodeURI($("#email").val());
	if($("#status").val() != "")
		url += "&status="+ $("#status").val();
		
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData(url);
}

$("#username").val("<?php echo $_GET['username']?>");
$("#fullname").val("<?php echo $_GET['fullname']?>");
$("#phone").val("<?php echo $_GET['phone']?>");
$("#address").val("<?php echo $_GET['address']?>");
$("#email").val("<?php echo $_GET['email']?>");
$("#status").val("<?php echo $_GET['status']?>");

function viewCongNo(id)
{
	$("#popup").attr('title','Công nợ');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					buttons: {
						'Đóng': function() {
							$( this ).dialog( "close" );
							
						},
						
						'In': function(){
							openDialog("?route=core/member/getCongNo&khachhangid="+id+"&dialog=print",800,500)
							
						},
					}
				});
			
				
	$("#popup-content").load("?route=core/member/getCongNo&khachhangid="+id+"&dialog=true",function(){
		$("#popup").dialog("open");	
	});
}

function moveto(url,eid)
{
	$('#'+eid).load(url);
}
</script>