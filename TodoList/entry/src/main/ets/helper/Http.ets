import http from '@ohos.net.http';
// import console from '../utils/console';

const TAG="[HttpService]"

export class HttpService{

  /**
   * HttpRequest对象，承担了发起/取消、订阅响应事件的职责
   */
  private httpClient:http.HttpRequest | undefined = undefined;
  public response:http.HttpResponse | undefined = undefined;

  constructor(){
    this.createHttpRequest();
    this.onHeaderReceive();
  }

  /**
   * 创建HttpRequest对象，并赋值给httpClient
   */
  private  createHttpRequest(){
    console.info(TAG,"start create HttpRequest");
    this.httpClient=http.createHttp();
    console.info(TAG,"create HttpRequest sucess ");
  }


  /**
   * 销毁http连接，中断数据请求
   */
  public destroy(){
    if (this.httpClient != null) {
      // 取消订阅HTTP响应头事件
      this.httpClient.off('headersReceive');
      // 取消订阅HTTP流式响应数据接收事件
      this.httpClient.off('dataReceive');
      this.httpClient.destroy();
      console.info(TAG, "HttpRequest destroyed")
    }
  }

  /**
   * 用于订阅http响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
   * 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)
   */
  private onHeaderReceive(){
    if (this.httpClient != null){
      this.httpClient.on("headersReceive",(data)=>{
        console.info(TAG,"ResponseHeader:"+JSON.stringify(data));
      })
    }
  }


  /**
   * 根据url和请求参数，向服务端发送http请求
   * @param url
   * @param param
   */
  public requestHttp(url:string,param:RequestParam): Promise<http.HttpResponse>{
    console.info(TAG,"start request:"+JSON.stringify(param));
    let requestOption : http.HttpRequestOptions = {
      method: http.RequestMethod.POST, //请求方式POST GET
      extraData: param.extraData, //body参数
      header: param.header, //header
      readTimeout: param.readTimeout,
      connectTimeout: param.connectTimeout
    }
    console.info(TAG, "the request param is:" + JSON.stringify(requestOption));
    console.info(TAG, "the url is:" + url);
    if (this.httpClient != null) {
      return this.httpClient.request(url,requestOption);
    }else {
      return http.createHttp().request(url,requestOption);
    }
  }

  public requestHttpWithOption(url:string, requestOption:http.HttpRequestOptions):Promise<http.HttpResponse> {
    console.info(TAG, "start request:" + JSON.stringify(requestOption));
    if (this.httpClient == null) {
      return http.createHttp().request(url, requestOption);
    } else {
      return this.httpClient.request(url, requestOption);
    }
  }
}

/**
 * 请求参数接口
 */
export interface RequestParam {

  method: string;

  extraData?: string | Object | ArrayBuffer;

  header?: Object; // default is 'content-type': 'application/json'

  readTimeout?: number; // default is 60s

  connectTimeout?: number; // default is 60s.
}

let httpService:HttpService=new HttpService();
export default httpService

