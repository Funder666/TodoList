/**
 * 读写手机本地保存的任务列表
 */
import fs from '@ohos.file.fs'
import common from '@ohos.app.ability.common'
import { TaskModel } from '../model/TaskModel'

export class FileHelper {
  // 保存Json数据
  static saveJsonData(jsonObj: Array<TaskModel>, fileName: string) {
    // 获取应用文件路径
    let context = getContext() as common.UIAbilityContext
    let filesDir = context.filesDir // 获取应用的文件夹路径
    let filePath = `${filesDir}/${fileName}` // 将文件名与文件夹路径连接起来，得到完整的文件路径
    // 新建并打开文件
    // 尝试打开文件
    try {
      // 以写入模式打开文件，并设置为只读、清空内容、创建模式
      let file = fs.openSync(filePath, fs.OpenMode.WRITE_ONLY | fs.OpenMode.TRUNC | fs.OpenMode.CREATE)
      // 将 JSON 对象转换为字符串
      let jsonStr = JSON.stringify(jsonObj)
      // 输出 JSON 字符串
      console.log("HMOS:" + jsonStr)
      // 将 JSON 字符串写入文件
      fs.writeSync(file.fd, jsonStr)
      // 关闭文件
      fs.closeSync(file)
    } catch (e) {
      // 输出文件写入错误信息
      console.log(`write file error ${e}`);
    }
  }

  // 读取Json数据
  static readJsonData(fileName: string):string {
    // 获取应用文件路径
    let context = getContext() as common.UIAbilityContext
    let filesDir = context.filesDir // 获取应用的文件夹路径
    let filePath = `${filesDir}/${fileName}` // 将文件名与文件夹路径连接起来，得到完整的文件路径
    let userStr = ""
    try {
      // 从文件路径中读取内容并将其存储在userStr变量中
      userStr = fs.readTextSync(filePath)

    } catch (e) {
      console.log(`read file error ${e}`);
    }
    if (userStr.length > 0) {
      console.log(userStr); // 输出userStr
      return userStr;
      // return JSON.parse(userStr); // 将userStr解析为JSON对象并返回
    }
    return "[]";
  }
}

