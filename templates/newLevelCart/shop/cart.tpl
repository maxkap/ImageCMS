<div class="frame-inside page-cart pageCart">
    <div class="container">
        <div class="js-empty empty {if count($items) == 0}d_b{/if}">
            <div class="f-s_0 title-cart without-crumbs">
                <div class="frame-title">
                    <h1 class="title">{lang('Оформление заказа','newLevel')}</h1>
                </div>
            </div>
            <div class="msg layout-highlight layout-highlight-msg">
                <div class="info">
                    <span class="icon_info"></span>
                    <span class="text-el">{lang('Корзина пуста','newLevel')}</span>
                </div>
            </div>
        </div>
        {if count($items) !== 0}
            <div class="js-no-empty no-empty">
                <div class="f-s_0 title-cart without-crumbs">
                    <div class="frame-title">
                        <h1 class="title">{lang('Оформление заказа','newLevel')}</h1>
                        {if !$is_logged_in}
                            <span class="old-buyer">
                                <button type="button" data-trigger="#loginButton">
                                    <span class="d_l text-el">{lang('Я уже здесь покупал','newLevel')}</span>
                                </button>
                            </span>
                        {/if}
                    </div>
                </div>
                <form method="post" action="{$BASE_URL}order/make_order" class="clearfix">
                    <div class="left-cart">
                        <div class="horizontal-form order-form big-title">
                            {if $errors}
                                <div class="groups-form">
                                    <div class="msg">
                                        <div class="error">
                                            <span class="icon_error"></span>
                                            <span class="text-el">{echo $errors}</span>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            <div class="groups-form">
                                <label>
                                    <span class="title">{lang('Имя: ','newLevel')}</span>
                                    <span class="frame-form-field">
                                        {if $isRequired['userInfo[fullName]']}
                                            <span class="must">*</span>
                                        {/if}
                                        <input type="text" value="{$profile.name}" name="userInfo[fullName]">
                                    </span>
                                </label>
                                <div class="frame-label">
                                    <span class="title">{lang('Телефон','newLevel')}:</span>
                                    <div class="frame-form-field">
                                        {if trim(ShopCore::app()->CustomFieldsHelper->setRequiredHtml('<span class="must">*</span>')->setPatternMain('pattern_custom_field_phone')->getOneCustomFieldsByName('addphone','order',$profile.id,'user')->asHtml()) != ''}
                                            <span class="f_r l-h_35">
                                                <button type="button" class="d_l_1" data-drop=".drop-add-phone" data-overlay-opacity="0" data-place="inherit">Еще один номер</button>
                                            </span>
                                        {/if}
                                        <div class="d_b o_h maskPhoneFrame">
                                            {if $isRequired['userInfo[phone]']}
                                                <span class="must">*</span>
                                            {/if}
                                            <input type="text" name="userInfo[phone]" value="{$profile.phone}" class="m-b_5">
                                            <div class="drop drop-add-phone">
                                                {echo ShopCore::app()->CustomFieldsHelper->setRequiredHtml('<span class="must">*</span>')->setPatternMain('pattern_custom_field_phone')->getOneCustomFieldsByName('addphone','order',$profile.id,'user')->asHtml()}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <label>
                                    <span class="title">{lang('Email','newLevel')}:</span>
                                    <span class="frame-form-field">
                                        {if $isRequired['userInfo[email]']}
                                            <span class="must">*</span>
                                        {/if}
                                        <input type="text" value="{$profile.email}" name="userInfo[email]">
                                    </span>
                                </label>
                                {echo ShopCore::app()->CustomFieldsHelper->setRequiredHtml('<span class="must">*</span>')->setPatternMain('pattern_custom_field')->getOneCustomFieldsByName('country','order',$profile.id,'user')->asHtml()}
                                {echo ShopCore::app()->CustomFieldsHelper->setRequiredHtml('<span class="must">*</span>')->setPatternMain('pattern_custom_field')->getOneCustomFieldsByName('Selo','order',$profile.id,'user')->asHtml()}
                            </div>
                            <div class="groups-form">
                                <div class="frame-label" id="frameDelivery">
                                    <span class="title">{lang('Доставка:','newLevel')}</span>
                                    {$counter = true}
                                    <div class="frame-form-field check-variant-delivery">
                                        {/* <div class="lineForm">
                                            <select id="method_deliv" name="deliveryMethodId">
                                                {foreach $deliveryMethods as $deliveryMethod}
                                        <option
                                            {if $counter}
                                                selected="selected"
                                                {$counter = false}
                                            {/if}
                                            name="met_del"
                                            value="{echo $deliveryMethod->getId()}"
                                            data-spec-sum="{echo $deliveryMethod->getDeliverySumSpecified()}"
                                            data-spec-sum-mes="{echo $deliveryMethod->getDeliverySumSpecifiedMessage()}"
                                            data-price="{echo $deliveryMethod->getPrice()}"
                                            data-price-add="{echo ShopCore::app()->SCurrencyHelper->convert($deliveryMethod->getPrice(), $NextCSId)}"
                                            data-free-from="{echo ceil($deliveryMethod->getFreeFrom())}">
                                            {echo $deliveryMethod->getName()}
                                        </option>
                                        {/foreach}
                                            </select>
                                        </div>*/}
                                        <div class="frame-radio">
                                            {foreach $deliveryMethods as $deliveryMethod}
                                                <div class="frame-label">
                                                    <span class="niceRadio b_n">
                                                        <input type="radio"
                                                               {if $counter}
                                                                   checked="checked"
                                                                   {$counter = false}
                                                                   {$idD}
                                                               {/if}
                                                               name="deliveryMethodId"
                                                               value="{echo $deliveryMethod->getId()}"
                                                               data-sum-spec="{echo $deliveryMethod->getDeliverySumSpecified()}"
                                                               data-sum-spec-mes="{echo $deliveryMethod->getDeliverySumSpecifiedMessage()}"
                                                               data-price="{echo $deliveryMethod->getPrice()}"
                                                               data-price-add="{echo ShopCore::app()->SCurrencyHelper->convert($deliveryMethod->getPrice(), $NextCSId)}"
                                                               data-free-from="{echo ceil($deliveryMethod->getFreeFrom())}"
                                                               />
                                                    </span>
                                                    <div class="name-count">
                                                        <span class="text-el">{echo $deliveryMethod->getName()}</span>
                                                        {if $deliveryMethod->getDescription() && trim($deliveryMethod->getDescription()) != ""}
                                                            <span class="icon_ask" data-rel="tooltip" data-title="{echo $deliveryMethod->getDescription()}"></span>
                                                        {/if}
                                                    </div>
                                                    <div class="help-block">
                                                        {if $deliveryMethod->getDeliverySumSpecified()}
                                                            {echo $deliveryMethod->getDeliverySumSpecifiedMessage()}
                                                        {else:}
                                                            <div>{lang('Стоимость','newLevel')}: {echo ceil($deliveryMethod->getPrice())} <span class="curr">{$CS}</span></div>
                                                            <div>{lang('Бесплатно от','newLevel')}: {echo ceil($deliveryMethod->getFreeFrom())} <span class="curr">{$CS}</span></div>
                                                        {/if}
                                                    </div>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="frame-label">
                                    <span class="title">Адрес доставки:</span>
                                    <span class="frame-form-field">
                                        {if $isRequired['userInfo[deliverTo]']}
                                            <span class="must">*</span>
                                        {/if}
                                        <input name="userInfo[deliverTo]" type="text" value="{$profile.address}"/>
                                    </span>
                                </div>
                                {echo ShopCore::app()->CustomFieldsHelper->setRequiredHtml('<span class="must">*</span>')->setPatternMain('pattern_custom_field')->getOneCustomFieldsByName('city','order',$profile.id,'user')->asHtml()}
                                <div class="frame-label">
                                    <div class="frame-form-field">
                                        <button type="button" class="d_l_1 m-b_5" data-drop=".hidden-comment" data-place="inherit" data-overlay-opacity="0">Добавить комментарий к заказу</button>
                                        <div class="hidden-comment drop">
                                            <textarea name="userInfo[commentText]" ></textarea>
                                        </div>
                                    </div>
                                </div>
                                {if count($paymentMethods)}
                                    <div class="frame-label">
                                        <span class="title">{lang('Оплата:','newLevel')}</span>
                                        <div class="frame-form-field check-variant-payment p_r">
                                            <div id="framePaymentMethod" class="frame-payment-method">
                                                {$counter = true}
                                                <div class="lineForm">
                                                    <select name="paymentMethodId" id="paymentMethod">
                                                        {foreach $paymentMethods as $paymentMethod}
                                                            <label>
                                                                <option
                                                                    {if $counter}
                                                                        checked="checked"
                                                                        {$counter = false}
                                                                    {/if}

                                                                    value="{echo $paymentMethod->getId()}"
                                                                    />
                                                                {echo $paymentMethod->getName()}
                                                                </option>
                                                            </label>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="preloader"></div>
                                        </div>
                                    </div>
                                {/if}
                            </div>
                            <div class="groups-form">
                                <div class="frame-label">
                                    <span class="title">&nbsp;</span>
                                    <span class="frame-form-field">
                                        <div class="btn-cart btn-cart-p">
                                            <input type="submit" class="btn btn_cart" value="{lang('Подтвердить заказ','newLevel')}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                </div>
                <div class="right-cart">
                    <div class="frame-bask frame-bask-order">
                        <div class="frame-title clearfix">
                            <div class="title f_l">{lang('Мой заказ', 'newLevel')}</div>
                            <div class="f_r">
                                <button type="button" class="d_l_1 editCart">{lang('Редактировать', 'newLevel')}</button>
                            </div>
                        </div>

                        <div id="orderDetails" class="p_r">
                            {include_tpl('cart_order')}
                        </div><!--End. orderdetails-->
                    </div>
                </div>
                <input type="hidden" name="makeOrder" value="1">
                <input type="hidden" name="checkCert" value="0">
                {form_csrf()}
                </form>
            </div>
            {/if}
            </div>
        </div>
        <script type="text/template" id="orderPaymentSelect">
            {literal}
                <div class = "lineForm">
                    <select id = "paymentMethod" name = "paymentMethodId" >
                        <% _.each(data, function(item) { %>
                        <option value = "<%-item.id%>"><%- item.name %></option>
                        <% }) %>
                    </select>
                </div>
            {/literal}
        </script>
        <script type="text/template" id="orderPaymentRadio">
            {literal}
                <div class="frame-radio">
                    <% var i=0 %>
                    <% _.each(data, function(item) { %>
                    <div class="frame-label">
                        <span class = "niceRadio b_n">
                            <input type = "radio" name = "paymentMethodId" value = "<%-item.id%>" <% if (i == 0){ %>checked = "checked"<% i++} %>/>
                        </span>
                        <div class = "name-count">
                            <span class = "text-el"><%-item.name%></span>
                        </div>
                        <div class="help-block"><%=item.description%></div>
                    </div>
                    <% }) %>
                </div>
            {/literal}
        </script>
        <script type="text/javascript">
            initDownloadScripts(['jquery.maskedinput-1.3.min', 'cusel-min-2.5', '_order'], 'initOrderTrEv', 'initOrder');
        </script>