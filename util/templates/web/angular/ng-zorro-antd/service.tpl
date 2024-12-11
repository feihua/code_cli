import {inject, Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {
  Add{{table_info.class_name}}Param,
  Delete{{table_info.class_name}}Param,
  QueryList{{table_info.class_name}}Param,
  Update{{table_info.class_name}}Param,
  Update{{table_info.class_name}}StatusParam,
  {{table_info.class_name}}RecordRes
} from "./data";
import {Observable} from "rxjs";
import {IResponse} from "../../../app.component";

@Injectable({
  providedIn: 'root'
})
export class {{table_info.class_name}}Service {
  private http = inject(HttpClient);

  constructor() {
  }

  /**
   * 添加{{table_info.table_comment}}
   * @param param
   */
  add{{table_info.class_name}}(param: Add{{table_info.class_name}}Param): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{table_info.object_name}}/add{{table_info.class_name}}', param);
  }

  /**
   * 删除{{table_info.table_comment}}
   * @param param
   */
  delete{{table_info.class_name}}(param: Delete{{table_info.class_name}}Param): Observable<IResponse<number>> {
    return this.http.get<IResponse<number>>('/api/demo/{{table_info.object_name}}/delete{{table_info.class_name}}?ids=[' + param.ids + ']');
  }

  /**
   * 更新{{table_info.table_comment}}
   * @param param
   */
  update{{table_info.class_name}}(param: Update{{table_info.class_name}}Param): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}', param);
  }

  /**
   * 更新{{table_info.table_comment}}状态
   * @param param
   */
  update{{table_info.class_name}}Status(param: Update{{table_info.class_name}}StatusParam): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}Status', param);
  }

  /**
   * 查询{{table_info.table_comment}}详情
   * @param id
   */
  query{{table_info.class_name}}Detail(id: number): Observable<IResponse<{{table_info.class_name}}RecordRes>> {
    return this.http.get<IResponse<{{table_info.class_name}}RecordRes>>('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}Detail?id=' + id, {});
  }

  /**
   * 查询{{table_info.table_comment}}列表
   * @param param
   */
  query{{table_info.class_name}}List(param: QueryList{{table_info.class_name}}Param): Observable<IResponse<{{table_info.class_name}}RecordRes[]>> {
    return this.http.get<IResponse<{{table_info.class_name}}RecordRes[]>>('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}List', {params: {...param}});
  }

}
