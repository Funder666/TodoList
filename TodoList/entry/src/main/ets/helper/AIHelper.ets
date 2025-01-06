
import httpService from './Http';
import http from '@ohos.net.http';

const TAG: string = "[TongYiThousandQHttp]"

const GENERATION_URL = "http://49.52.27.74:11434/api/generate";

export class LLM {

  public static openSEE: boolean = true



  static async getHttpResult(prompt: string): Promise<string> {
    let res: string = "";
    let option: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        "Content-Type": 'application/json',
      },
      extraData: {
        "model": "qwen2.5:32b",
        "prompt": prompt,
        "stream": false
      },
      expectDataType:0
    };

    try {
      let httpRequest = http.createHttp();

      let promise = await httpRequest.request(GENERATION_URL, option);

      if (promise && promise.result) {
        try {
          // 假设 result 是 JSON 格式字符串

          const resultObj:string = JSON.parse(promise.result.toString());

          // 提取 response 字段
          if (resultObj["response"]) {
            res = resultObj["response"];
            console.log("提取的 response 字段: ", res);
          } else {
            console.error("未找到 response 字段:?",promise.result["response"]);
          }
        } catch (parseError) {
          console.error("解析 result 失败: ", parseError.message);
        }
      } else {
        console.error("请求结果无效: ", promise);
      }
    } catch (error) {
      console.error("HTTP 请求失败: ", error.message);
    }

    return res;
  }

}