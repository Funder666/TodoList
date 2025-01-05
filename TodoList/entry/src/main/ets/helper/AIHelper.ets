
import httpService from './Http';
import http from '@ohos.net.http';

const TAG: string = "[TongYiThousandQHttp]"
const API_KEY = 'xxx';
const GENERATION_URL = "https://dashscope.aliyuncs.com/api/v1/services/aigc/text-generation/generation";

export class TongYiThousandQHttp {
  public static openSEE: boolean = true
  private prompt: string = ''
  private result: string = ''
  private requestOptions: http.HttpRequestOptions = {}

  constructor(prompt: string) {
    this.prompt = prompt
  }

  InitParam() {
    this.requestOptions = {
      method: http.RequestMethod.POST,
      header: {
        "Content-Type": 'application/json',
        Authorization: `Bearer ${API_KEY}`,
        'X-DashScope-SSE': 'enable'
      },
      extraData: {
        model: 'qwen-turbo',
        input: {
          messages: [{ 'role': 'system', 'content': 'You are a helpful assistant.' },
            { 'role': 'user', 'content': this.prompt }]
        },
        parameters: {
          result_format: "message"
        }
      }
    }
  }

  getHttpResult(callback: (result: string, time: number) => void) {
    let time1: Date = new Date();
    this.InitParam()
    httpService.requestHttpWithOption(GENERATION_URL, this.requestOptions).then((data: http.HttpResponse) => {
      console.info(TAG, "send request sucess,the response is:" + JSON.stringify(data));
      let time2: Date = new Date();
      let costTime = time2.getTime() - time1.getTime();
      if (data.responseCode != 200 || data.responseCode == null) {
        this.result = '获取结果失败，请重试'
      } else {
        this.result = data.result as string
      }
      callback(this.result, costTime)
    }).catch((err: Error) => {
      console.info(TAG, 'error:' + JSON.stringify(err));
    });
  }
}