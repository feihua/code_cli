import {Component, inject, OnInit} from '@angular/core';
import {NzTableComponent, NzTableModule, NzTableQueryParams} from "ng-zorro-antd/table";
import {NzDividerComponent} from "ng-zorro-antd/divider";
import {NzButtonComponent} from "ng-zorro-antd/button";
import {
  FormControl,
  FormGroup,
  FormsModule,
  NonNullableFormBuilder,
  ReactiveFormsModule,
  Validators
} from "@angular/forms";
import {NzFormDirective, NzFormLabelComponent, NzFormModule} from "ng-zorro-antd/form";
import {NzColDirective, NzRowDirective} from "ng-zorro-antd/grid";
import {NzInputDirective, NzInputGroupComponent, NzTextareaCountComponent} from "ng-zorro-antd/input";
import {NzIconDirective} from "ng-zorro-antd/icon";
import {NzSpaceComponent, NzSpaceItemDirective} from "ng-zorro-antd/space";
import {NzOptionComponent, NzSelectComponent} from "ng-zorro-antd/select";
import {NzModalComponent, NzModalModule, NzModalService} from "ng-zorro-antd/modal";
import {NzDescriptionsComponent, NzDescriptionsItemComponent} from "ng-zorro-antd/descriptions";
import { {{table_info.class_name}}Service} from "./{{table_info.object_name}}.service";
import {AsyncPipe, NgIf} from "@angular/common";
import { {{table_info.class_name}}RecordRes} from "./data";
import {NzInputNumberComponent} from "ng-zorro-antd/input-number";
import {NzRadioComponent, NzRadioGroupComponent, NzRadioModule} from "ng-zorro-antd/radio";
import {NzMessageService} from "ng-zorro-antd/message";
import {NzSwitchComponent} from "ng-zorro-antd/switch";


@Component({
  selector: 'app-{{table_info.object_name}}',
  standalone: true,
  imports: [
    NzTableComponent,
    NzDividerComponent,
    NzTableModule,
    NzButtonComponent,
    NzFormDirective,
    ReactiveFormsModule,
    NzRowDirective,
    NzColDirective,
    NzInputDirective,
    NzFormLabelComponent,
    NzIconDirective,
    NzFormModule,
    NzSpaceComponent,
    NzSpaceItemDirective,
    NzInputGroupComponent,
    NzSelectComponent,
    NzOptionComponent,
    NzModalComponent,
    NzModalModule,
    NzTextareaCountComponent,
    NzDescriptionsComponent,
    NzDescriptionsItemComponent,
    NgIf,
    AsyncPipe,
    NzInputNumberComponent,
    NzRadioGroupComponent,
    NzRadioComponent,
    NzRadioModule,
    NzSwitchComponent,
    FormsModule
  ],
  templateUrl: './component.html',
  styleUrl: './component.css'
})
export class {{table_info.class_name}}Component implements OnInit {
  private fb = inject(NonNullableFormBuilder);
  private modal = inject(NzModalService);
  private {{table_info.object_name}}Service = inject({{table_info.class_name}}Service);
  private message = inject(NzMessageService);

  // 分页相关参数
  total = 1;
  pageSize = 10;
  pageIndex = 1;
  listData!: {{table_info.class_name}}RecordRes[];
  detailData!: {{table_info.class_name}}RecordRes;

  isAddVisible = false;
  isAddOkLoading = false;

  isUpdateVisible = false;
  isUpdateOkLoading = false;

  isDetailVisible = false;

  searchForm: FormGroup<{
  {%- for column in table_info.columns %}
  {{column.ts_name}}: FormControl<{{column.ts_type}}>, //{{column.column_comment}}
  {%- endfor %}
  }> = this.fb.group({
  {%- for column in table_info.columns %}
  {{column.ts_name}}: '', //{{column.column_comment}}
  {%- endfor %}
  });

  submitSearchForm(): void {
    console.log('submit', this.searchForm.value);
    this.pageIndex = 1;
    this.pageSize = 10;
    this.query{{table_info.class_name}}List();

  }

  resetSearchForm(): void {
    this.searchForm.reset();
  }

  // 新增相关参数
  addForm: FormGroup<{
  {%- for column in table_info.columns %}
  {{column.ts_name}}: FormControl<{{column.ts_type}}>, //{{column.column_comment}}
  {%- endfor %}
  }> = this.fb.group({
  {%- for column in table_info.columns %}
  {{column.ts_name}}: '', //{{column.column_comment}}
  {%- endfor %}
  });

  showAddModal(): void {
    this.isAddVisible = true;
  }

  handleAddOk(): void {
    this.isAddOkLoading = true;
    console.log('handleAddOk submit', this.addForm.value);
    const addRecord = this.addForm.value
    this.{{table_info.object_name}}Service.add{{table_info.class_name}}({
      {%- for column in table_info.columns %}
      {{column.ts_name}}: addRecord.{{column.ts_name}}, //{{column.column_comment}}
      {%- endfor %}
    }).subscribe(res => {
      this.message.create(res.code == 0 ? 'success' : 'error', res.message);
      this.isAddOkLoading = false;
      if (res.code == 0) {
        this.isAddVisible = false;
        this.query{{table_info.class_name}}List();

      }
    })
  }

  handleAddCancel(): void {
    this.addForm.reset();
    this.isAddVisible = false;
  }

  updateForm: FormGroup<{
  {%- for column in table_info.columns %}
  {{column.ts_name}}: FormControl<{{column.ts_type}}>, //{{column.column_comment}}
  {%- endfor %}
  }> = this.fb.group({
  {%- for column in table_info.columns %}
  {{column.ts_name}}: '', //{{column.column_comment}}
  {%- endfor %}
  });


  showUpdateModal(record: {{table_info.class_name}}RecordRes): void {
    this.isUpdateVisible = true;
    this.{{table_info.object_name}}Service.query{{table_info.class_name}}Detail(record.id).subscribe(res => {
      this.detailData = res.data
      const updateRecord = res.data
      this.updateForm = this.fb.group({
        {%- for column in table_info.columns %}
        {{column.ts_name}}: [updateRecord.{{column.ts_name}}, [Validators.required]],
        {%- endfor %}
      })
    })
  }

  handleUpdateOk(): void {
    this.isUpdateOkLoading = true;
    console.log('handleUpdateOk submit', this.updateForm.value);
    const updateRecord = this.updateForm.value
    this.{{table_info.object_name}}Service.update{{table_info.class_name}}({
      {%- for column in table_info.columns %}
      {{column.ts_name}}: updateRecord.{{column.ts_name}}, //{{column.column_comment}}
      {%- endfor %}
    }).subscribe(res => {
      this.message.create(res.code == 0 ? 'success' : 'error', res.message);
      this.isUpdateOkLoading = false;
      if (res.code == 0) {
        this.isUpdateVisible = false;
        this.query{{table_info.class_name}}List();
      }
    })
  }

  handleUpdateCancel(): void {
    this.updateForm.reset();
    this.isUpdateVisible = false;
  }

  showDetailModal(record: {{table_info.class_name}}RecordRes): void {
    this.isDetailVisible = true;
    this.{{table_info.object_name}}Service.query{{table_info.class_name}}Detail(record.id).subscribe(res => {
      this.detailData = res.data
    })
  }

  handleDetailCancel(): void {
    this.isDetailVisible = false;
  }

  showDeleteConfirm(recordIds: number[]): void {
    this.modal.confirm({
      nzTitle: '你确定要删除吗?',
      // nzContent: '<b style="color: red;">删除后数据不能恢复!</b>',
      nzOkText: '是',
      nzOkType: 'primary',
      nzOkDanger: true,
      nzOnOk: () => {
        this.{{table_info.object_name}}Service.delete{{table_info.class_name}}({
          ids: recordIds
        }).subscribe(res => {
          this.message.create(res.code == 0 ? 'success' : 'error', res.message);
          if (res.code == 0) {
            this.query{{table_info.class_name}}List();
          }
        })
      },
      nzCancelText: '否',
      nzOnCancel: () => console.log('Cancel')
    });
  }

  // 批量选择
  checked = false;
  indeterminate = false;
  listOfCurrentPageData: readonly {{table_info.class_name}}RecordRes[] = [];
  setOfCheckedId = new Set<number>();

  updateCheckedSet(id: number, checked: boolean): void {
    if (checked) {
      this.setOfCheckedId.add(id);
    } else {
      this.setOfCheckedId.delete(id);
    }
  }

  onCurrentPageDataChange(listOfCurrentPageData: readonly {{table_info.class_name}}RecordRes[]): void {
    this.listOfCurrentPageData = listOfCurrentPageData;
    this.refreshCheckedStatus();
  }

  refreshCheckedStatus(): void {
    const listOfEnabledData = this.listOfCurrentPageData;
    this.checked = listOfEnabledData.every(({id}) => this.setOfCheckedId.has(id));
    this.indeterminate = listOfEnabledData.some(({id}) => this.setOfCheckedId.has(id)) && !this.checked;
  }

  onItemChecked(id: number, checked: boolean): void {
    this.updateCheckedSet(id, checked);
    this.refreshCheckedStatus();
  }

  onAllChecked(checked: boolean): void {
    this.listOfCurrentPageData.forEach(({id}) => this.updateCheckedSet(id, checked));
    this.refreshCheckedStatus();
  }

  batchDelete(): void {
    this.showDeleteConfirm(Array.from(this.setOfCheckedId))
  }

  // 分页查询
  onQueryParamsChange(params: NzTableQueryParams): void {
    const {pageSize, pageIndex} = params;
    this.pageIndex = pageIndex
    this.pageSize = pageSize
    this.query{{table_info.class_name}}List();
  }

  clickSwitch(res: {{table_info.class_name}}RecordRes): void {
    console.log('clickSwitch', res);
    this.{{table_info.object_name}}Service.update{{table_info.class_name}}Status({
      ids: [res.id],
      status: 0,
    }).subscribe(res => {
      this.message.create(res.code == 0 ? 'success' : 'error', res.message);
      if (res.code == 0) {
        this.query{{table_info.class_name}}List();
      }
    })

  }


  private query{{table_info.class_name}}List() {
    const {  {%- for column in table_info.columns %}
    {{column.ts_name}}, //{{column.column_comment}}
    {%- endfor %}
    } = this.searchForm.value;
    this.{{table_info.object_name}}Service.query{{table_info.class_name}}List({
      current: this.pageIndex,
      pageSize: this.pageSize,
  {%- for column in table_info.columns %}
  {{column.ts_name}},
  {%- endfor %}
    }).subscribe(res => {
      this.listData = res.data
      this.total = res.total
    })
  }

  ngOnInit(): void {
  }


}
