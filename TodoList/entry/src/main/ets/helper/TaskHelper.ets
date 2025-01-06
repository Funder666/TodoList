/**
 * 读写手机本地保存的任务列表的工具类
 */
import { TaskModel } from '../model/TaskModel';
import { FileHelper } from './FileHelper';

export class TaskHelper {
  static getIndexByTaskId(taskList: Array<TaskModel>, taskId: number) {
    // 遍历任务列表
    for (let i = 0; i < taskList.length; i++) {
      // 如果任务id相等
      if (taskList[i].taskId == taskId) {
        // 返回索引
        return i
      }
    }
    // 如果没有找到，返回-1
    return -1
  }
  static getTaskContent(taskList: Array<TaskModel>){
    let content:string=""
    let content_complete:string="已经完成的任务有："
    let content_incomplete:string="还未完成的任务有："
    for(let i=0;i<taskList.length;i++){
      if(taskList[i].isCompleted){
        content_complete+=taskList[i].taskContent+"，"
      }else{
        content_incomplete+=taskList[i].taskContent+"，"
      }
    }
    content=content_complete+content_incomplete
    console.log(content)
    return content
  }
  // 保存任务列表
  static saveTaskList(taskList: Array<TaskModel>) {
    // 使用FileHelper类的saveJsonData方法，将任务列表数据保存到task.data文件中
    FileHelper.saveJsonData(taskList, 'task.data')
  }

  // 读取任务列表
  static readTaskList(): Array<TaskModel> {
    // 读取任务数据
    let jsonData:string = FileHelper.readJsonData('task.data')
    console.info("jsonData=====",jsonData);
    // 创建任务列表
    let taskList: Array<TaskModel> = []
    // 将json数据赋值给任务列表

    try{
      taskList = JSON.parse(jsonData)
    }catch(e){
      console.info("error=====",e);
    }
    // 返回任务列表
    return taskList
  }
}