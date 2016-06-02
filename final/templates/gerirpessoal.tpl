{include file='common/header.tpl'}

<body>
    {include file='common/navbar.tpl'}

    <div class="container-fluid">
        <div class="row">
            {include file='common/sidebar_adm.tpl'}

            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Gerir Pessoal</h1>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Email</th>
                                <th>Género</th>
                                <th>Data Nascimento</th>
                                <th>Telemóvel</th>
                                <th>NIF</th>
                                <th>Tipo Donativo</th>
                                <th>Periodicidade</th>
                                <th>Cargo</th>
                                <th>Opções</th>
                            </tr>
                        </thead>
                        <tbody id="users">

                            {foreach $users as $key => $user} {if $user.role === 'Amigo' && $user.frozen}
                            <tr class="warning" id="user{$user.id}">
                                {else}
                                <tr id="user{$user.id}">
                                    {/if}
                                    <td>{$user.id}</td>
                                    <td>{$user.name}</td>
                                    <td>{$user.email}</td>
                                    <td>{$user.gender}</td>
                                    <td>{$user.birth}</td>
                                    {if $user.role === 'Amigo'}
                                    <td>{$user.cellphone}</td>
                                    <td>{$user.nif}</td>
                                    <td>{$user.donative_type}</td>
                                    <td>{$user.periodicity}</td>
                                    {else}
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    {/if}
                                    <td>{$user.role}</td>
                                    <td>
                                        <a href="user.php?user={$user.id}" class="fa fa-eye fa-lg fa-fw clickable" data-toggle="tooltip" data-original-title="Ver"></a>
                                        <i data-toggle="modal" data-target="#notificationModal">
                                            <i class="fa fa-bullhorn fa-lg fa-fw clickable" data-toggle="tooltip" data-original-title="Notificar"></i>
                                        </i>
                                        {if $role === 'Administrador'}
                                        <i data-toggle="modal" data-target="#userModal">
                                                <i class="fa fa-pencil fa-lg fa-fw clickable" data-toggle="tooltip" data-original-title="Editar"></i>
                                        </i>
                                        <i class="fa fa-trash fa-lg fa-fw clickable" data-toggle="tooltip" data-original-title="Eliminar"></i> {elseif $role === 'Contabilista' && $user.role === 'Amigo'} {if $user.frozen}
                                        <i id="user{$user.id}-frozen" class="fa fa-play fa-lg fa-fw clickable" data-toggle="tooltip" data-original-title="Descongelar"></i> {else}
                                        <i id="user{$user.id}-frozen" class="fa fa-pause fa-lg fa-fw clickable" data-toggle="tooltip" data-original-title="Congelar"></i> {/if} {/if}
                                    </td>
                                </tr>
                                {/foreach}

                        </tbody>
                    </table>
                </div>
                <button id="newUser" type="button" class="btn btn-default" data-toggle="modal" data-target="#userModal">
                    <i class="fa fa-user-plus"></i> Novo Utilizador
                </button>
            </div>
        </div>
    </div>


    <!-- Register / Edit user modal -->
    <div class="modal fade" tabindex="-1" role="dialog" id="userModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 id="userModalTitle" class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <form role="form" id="userForm">
                        <div class="form-group">
                            <label for="identification">ID:</label>
                            <input class="form-control" id="identification" required="required">
                        </div>
                        <div class="form-group">
                            <label for="name">Nome:</label>
                            <input class="form-control" id="name" required="required">
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" id="email" required="required">
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" class="form-control" id="password" required="required">
                        </div>
                        <div class="form-group">
                            <label for="gender">Género:</label>
                            <select class="form-control" id="gender" required="required">
                                <option>M</option>
                                <option>F</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="birthdate">Data de Nascimento:</label>
                            <input type="date" class="form-control" id="birthdate" required="required">
                        </div>
                        <div class="form-group">
                            <label for="role">Cargo:</label>
                            <select class="form-control" id="role" required="required">
                                <option>Amigo</option>
                                <option>Administrador</option>
                                <option>Contabilista</option>
                            </select>
                        </div>

                        <div id="friendOnlyParams">
                            <div class="form-group">
                                <label for="nif">NIF:</label>
                                <input class="form-control" id="nif" required="required">
                            </div>
                            <div class="form-group">
                                <label for="cellphone">Telemóvel:</label>
                                <input type="tel" class="form-control" id="cellphone" required="required">
                            </div>
                            <div class="form-group">
                                <label for="paymethod">Metodo de Pagamento:</label>
                                <select class="form-control" id="paymethod" required="required">
                                    <option>Referência Multibanco</option>
                                    <option>Numerário</option>
                                    <option>Transferência Bancária</option>
                                    <option>Débito Direto</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="freq">Frequencia de Pagamento</label>
                                <select class="form-control" id="periodicity" required="required">
                                    <option>Mensal</option>
                                    <option>Trimestral</option>
                                    <option>Semestral</option>
                                    <option>Anual</option>
                                </select>
                            </div>
                        </div>

                    </form>
                    <div class="alert alert-danger alert-dismissible" style="display: none;" role="alert" id="userStatus">
                        <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span>
                        </button>
                        Failed to complete the action! Please verify the information.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                    <button type="submit" form="userForm" class="btn btn-primary">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification modal -->
    <div class="modal fade" tabindex="-1" role="dialog" id="notificationModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Adicionar Notificação</h4>
                </div>
                <div class="modal-body">
                    <form role="form" id="notificationForm">
                        <div class="form-group">
                            <label for="notificationUserId">ID:</label>
                            <input class="form-control" id="notificationUserId" required="required" disabled="disabled">
                        </div>
                        <div class="form-group">
                            <label for="identification">Mensagem:</label>
                            <input class="form-control" id="notification" required="required">
                        </div>
                        <div class="form-group">
                            <label for="role">Tipo:</label>
                            <select class="form-control" id="notificationType" required="required">
                                <option value="Success">Sucesso</option>
                                <option value=" Info ">Informação</option>
                                <option value="Warning ">Aviso</option>
                                <option value="Danger ">Importante</option>
                            </select>
                        </div>
                    </form>
                    <div class="alert alert-danger alert-dismissible " style="display: none; " role="alert " id="userStatus ">
                        <button type="button " class="close " aria-label="Close "><span aria-hidden="true ">&times;</span>
                        </button>
                        Failed to add the notification!
                    </div>
                </div>
                <div class="modal-footer ">
                    <button type="button " class="btn btn-default " data-dismiss="modal ">Fechar</button>
                    <button type="submit " form="userForm " class="btn btn-primary ">Adicionar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- JQuery -->
    <script src="{$BASE_URL}js/vendor/jquery.min.js "></script>

    <!-- JQuery UI -->
    <script src="{$BASE_URL}js/vendor/jquery-ui.min.js "></script>

    <!-- Bootstrap -->
    <script src="{$BASE_URL}js/vendor/bootstrap.min.js "></script>

    <!-- G.A.S.Porto -->
    <script src="{$BASE_URL}js/gerirpessoal.min.js "></script>
</body>

{include file='common/footer.tpl'}
