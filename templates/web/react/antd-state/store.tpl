import { create } from 'zustand';
import { query{{table_info.class_name}}List1 } from '../service.ts';
import { List{{table_info.class_name}}Param, {{table_info.class_name}}Vo } from '../data';

interface {{table_info.class_name}}State {
  listParam: List{{table_info.class_name}}Param;
  {{table_info.object_name}}List: {{table_info.class_name}}Vo[];
  total: number;
  query{{table_info.class_name}}List: (params: List{{table_info.class_name}}Param) => void;
}

const use{{table_info.class_name}}Store = create<{{table_info.class_name}}State>()((set) => ({
  listParam: {
    current: 1,
    pageSize: 10,
  },
  total: 10,
  {{table_info.object_name}}List: [],
  query{{table_info.class_name}}List: (params: List{{table_info.class_name}}Param) => {
    set({ listParam: params });
    query{{table_info.class_name}}List1(params).then((res) => {
      set({
        {{table_info.object_name}}List: res.data,
        total: res.total,
      });
    });
  },
}));

export default use{{table_info.class_name}}Store;
