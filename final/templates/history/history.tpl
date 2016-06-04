<div class="container">
    <h2>Histórico</h2></div>

<div id="Tabs" class="container">
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#TabIrEvento" data-toggle="tab">Ida a Eventos</a>
        </li>
        <li><a href="#TabPagEvento" data-toggle="tab">Pagamento Eventos</a>
        </li>
        <li><a href="#TabDonative" data-toggle="tab">Donativos</a>
        </li>
        <li><a href="#TabMercha" data-toggle="tab">Merchandise</a>
        </li>
    </ul>

    <div class="tab-content ">
        <div class="tab-pane active" id="TabIrEvento">
            {include file='history/friend_event.tpl'}
        </div>
        <div class="tab-pane" id="TabPagEvento">
            {include file='history/payment_event.tpl'}
        </div>
        <div class="tab-pane" id="TabDonative">
            {include file='history/donative.tpl'}
        </div>

        <div class="tab-pane" id="TabMercha">
            {include file='history/mercha.tpl'}
        </div>
    </div>
</div>