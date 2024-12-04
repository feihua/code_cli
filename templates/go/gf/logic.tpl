package assetmanager_approval_record

/*
{{table_info.table_comment}}相关逻辑
Author: {{author}}
Date: {{create_time}}
*/

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{project_name}}/internal/dao"
	"{{project_name}}/internal/model"
	"{{project_name}}/internal/service"
)

type s{{table_info.class_name}} struct {
}

func init() {
	service.Register{{table_info.class_name}}(New())
}

func New() *s{{table_info.class_name}} {
	return &s{{table_info.class_name}}{}
}

// Add{{table_info.class_name}} 添加{{table_info.table_comment}}
func (s *s{{table_info.class_name}}) Add{{table_info.class_name}}(ctx context.Context, in model.Add{{table_info.class_name}}Input) (*model.Add{{table_info.class_name}}Output, error) {

	out := &model.Add{{table_info.class_name}}Output{}

	_, err := dao.{{table_info.original_class_name}}.Ctx(ctx).Data(in).Insert()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Delete{{table_info.class_name}} 删除{{table_info.table_comment}}
func (s *s{{table_info.class_name}}) Delete{{table_info.class_name}}(ctx context.Context, in model.Delete{{table_info.class_name}}Input) (*model.Delete{{table_info.class_name}}Output, error) {

	out := &model.Delete{{table_info.class_name}}Output{}

	_, err := dao.{{table_info.original_class_name}}.Ctx(ctx).WhereIn("id", in.Ids).Delete()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Update{{table_info.class_name}} 更新{{table_info.table_comment}}
func (s *s{{table_info.class_name}}) Update{{table_info.class_name}}(ctx context.Context, in model.Update{{table_info.class_name}}Input) (*model.Update{{table_info.class_name}}Output, error) {

	out := &model.Update{{table_info.class_name}}Output{}

	_, err := dao.{{table_info.original_class_name}}.Ctx(ctx).Data(in).Where("id", in.Id).Update()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Update{{table_info.class_name}}Status 更新{{table_info.table_comment}}状态
func (s *s{{table_info.class_name}}) Update{{table_info.class_name}}Status(ctx context.Context, in model.Update{{table_info.class_name}}StatusInput) (*model.Update{{table_info.class_name}}StatusOutput, error) {

	out := &model.Update{{table_info.class_name}}StatusOutput{}

	_, err := dao.{{table_info.original_class_name}}.Ctx(ctx).Data(in).Where("id", in.Ids).Update()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Record{{table_info.class_name}}Detail 查询{{table_info.table_comment}}详情
func (s *s{{table_info.class_name}}) Query{{table_info.class_name}}Detail(ctx context.Context, in model.Query{{table_info.class_name}}DetailInput) (*model.Query{{table_info.class_name}}DetailOutput, error) {

	out := &model.Query{{table_info.class_name}}DetailOutput{}

	record, err := dao.{{table_info.original_class_name}}.Ctx(ctx).Where("id", in.Id).One()
	if err != nil {
		return nil, err
	}

	err = gconv.Struct(record, out.Record)
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Query{{table_info.class_name}}List 查询{{table_info.table_comment}}
func (s *s{{table_info.class_name}}) Query{{table_info.class_name}}List(ctx context.Context, in model.Query{{table_info.class_name}}ListInput) (*model.Query{{table_info.class_name}}ListOutput, error) {

	out := &model.Query{{table_info.class_name}}ListOutput{
		PageNum:  in.PageNum,
		PageSize: in.PageSize,
	}
	m := dao.{{table_info.original_class_name}}.Ctx(ctx)

	if err := m.Page(in.PageNum, in.PageSize).Scan(&out.List); err != nil {
		return nil, err
	}

	out.Total, _ = m.Count()
	return out, nil
}
