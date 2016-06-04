<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">G.A.S.Porto</a>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="amigo.php"><i class="fa fa-user"></i> {$user.name} ({$user.role})</a></li>
                <li id="notifications" class="dropdown">
                    <a href="#" class="dropdown-toggle"><i class="fa fa-bell"></i> Notificações
                        <span class="badge">{$notifications|@count}</span></a>

                    <ul class="dropdown-menu list-group">

                        {foreach $notifications as $notification}
                        <li id="notification{$notification.id}" class="list-group-item list-group-item-{$notification.notification_type|@strtolower}">{$notification.description}</li>
                        {/foreach}

                    </ul>

                </li>
                <li><a href="{$BASE_URL}actions/logout.php"><i class="fa fa-sign-out"></i> Sair</a></li>
            </ul>
            {if $viewer.role !== "Amigo"}
            <form class="navbar-form navbar-right" role="search" action="pesquisa.php" method="GET">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Procurar" name="user">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </form>
            {/if}
        </div>
    </div>
</nav>

<script src="{$BASE_URL}js/common/navbar.min.js"></script>
