<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 *  Прототип модуля в AOmega.Blog
 *
 * @version 1.0
 * @author Ibragimov "MpaK" Renat <info@mrak7.com>
 * @copyright Copyright (c) 2011 http://aomega.ru
 */
class AOmegaModule extends MX_Controller{
    public
        $iam        = '' // кто я такой и мои параметры
    ;

    /**
     * Конструктор
     */
    public function __constuct(){
        parent::__construct();
    }

    /**
     * Возвращаем информацию о модуле
     *
     * @return array
     */
    public function info(){
        return array(
            'version'   => ':version',
            'title'     => ':title',
            'name'      => ':name',
            'description'   => ':description',

            'methods'   => array(
                array( 'title'=>':title', 'method'=>':method', 'place' => ':pt', 'type' => 'pb'),
            )
        );
    }

    /**
     * Перекачка переменных для инициализации
     * 
     * @param array $params 
     */
    public function initialize( $params=NULL ){
        if( is_array($params) ){
            foreach( $params as $key=>$value ){
                $this->$key = $value;
            }
        }
    }

    /**
     * Событие когда нас удаляют со страницы сообщения
     *
     * @param  array $params
     * @return bool
     */
    public function on_remove( $params=NULL ){
        return TRUE;
    }

    /**
     * Событие когда нас ставят на страницу сообщения
     *
     * @param  array $params
     * @return bool
     */
    public function on_insert( $params=NULL ){
        return TRUE;
    }

}