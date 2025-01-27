/**
 * Index页面 主要用来 调用页面和函数
 */
import { TaskHelper } from '../helper/TaskHelper'
import { AddPage } from './AddPage'
import { ListPage } from './ListPage'
import { TaskModel } from '../model/TaskModel'
import { ThemesPage } from './ThemesPage'
import { AIPage } from './AIPage'
import { SummaryPage } from './SummaryPage'

@Entry
@Component
struct MainPage {
  // 是否显示添加页面
  @State displayAddPage: boolean = false
  @State displayThemesPage: boolean = false
  @State displayAIPage: boolean = false
  @State displaySummaryPage:boolean = false
  // 任务列表
  @State @Watch('saveTaskList') taskList: Array<TaskModel> = []
  // 总任务数量
  @State totalTask: number = 0
  // 己完成任务数量
  @State finishTask: number = 0
  @State bgColor: string = '#BCCEDA'

  saveTaskList() {
    TaskHelper.saveTaskList(this.taskList)
  }

  aboutToAppear() {
    this.taskList = TaskHelper.readTaskList()
    //1.更新任务总数量
    this.totalTask = this.taskList.length
    //2.更新已完成任务数量
    this.finishTask = this.taskList.filter(item => item.isCompleted).length
  }

  build() {
    if (this.displayAddPage) {
      AddPage({
        displayAddPage: $displayAddPage,
        taskList: $taskList,
        totalTask: $totalTask,
        finishTask: $finishTask,
        bgColor: $bgColor
      })
    } else if (this.displayThemesPage) {
      ThemesPage({
        displayThemesPage: $displayThemesPage,
        bgColor: $bgColor
      })
    } else if (this.displayAIPage) {
      AIPage({
        displayAIPage: $displayAIPage,
        taskList: $taskList,
        finishTask:$finishTask,
        totalTask:$totalTask,
        bgColor: $bgColor,
        displaySummaryPage:$displaySummaryPage
      })

    }
    else if (this.displaySummaryPage) {
      SummaryPage({
        displaySummaryPage: $displaySummaryPage,
        taskList: $taskList,
        bgColor: $bgColor,
        displayAIPage: $displayAIPage,
      })

    }else {
      ListPage({
        displayAddPage: $displayAddPage,
        displayThemesPage: $displayThemesPage,
        displaySummaryPage: $displaySummaryPage,
        taskList: $taskList,
        totalTask: $totalTask,
        finishTask: $finishTask,
        bgColor: $bgColor,
      })
    }
  }
}