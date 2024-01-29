import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:marian/data/_shared/failure.dart';
import 'package:marian/domain/_shared/entities/paging.dart';
import 'package:marian/domain/task/entities/task.dart';
import 'package:marian/presentation/pages/task_list/task_list_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/pump_app.dart';

final pageMock = Paging<Task>(currentPage: 0, totalPages: 2, items: [
      Task(
        id: "ID-1",
        title: "First Title",
        description: "This is a long description",
        status: TaskStatus.toDo,
        created: DateTime.parse('2024-01-01T12:00:00Z'),
      ),
      Task(
        id: "ID-2",
        title: "Second Title",
        description: "This is a long description",
        status: TaskStatus.toDo,
        created: DateTime.parse('2024-01-02T12:00:00Z'),
      ),
    ]);

final taskDisplayedMock = <TaskDisplayed> [
  TaskDisplayed.fromDate(pageMock.items?[0].created ?? DateTime.now()),
  TaskDisplayed.fromTask(pageMock.items?[0] ?? Task(id: '')),
  TaskDisplayed.fromDate(pageMock.items?[1].created ?? DateTime.now()),
  TaskDisplayed.fromTask(pageMock.items?[1] ?? Task(id: '')),
];

final taskDisplayedDeleteMock = <TaskDisplayed> [
  TaskDisplayed.fromDate(pageMock.items?[1].created ?? DateTime.now()),
  TaskDisplayed.fromTask(pageMock.items?[1] ?? Task(id: '')),
];

final pageMock2 = Paging<Task>(currentPage: 1, totalPages: 2, items: [
      Task(
        id: "ID-3",
        title: "Last Title",
        description: "This is a long description",
        status: TaskStatus.toDo,
        created: DateTime.parse('2024-01-02T12:00:00Z'),
      ),
    ]);

final taskDisplayedMock2 = <TaskDisplayed> [
  TaskDisplayed.fromDate(pageMock2.items?[0].created ?? DateTime.now()),
  TaskDisplayed.fromTask(pageMock2.items?[0] ?? Task(id: '')),
];

void main() {
  group('TaskListCubit', () {
    late MockTaskRepository mockTaskRepository;
    late TaskListCubit cubit;

    setUp(() {
      mockTaskRepository = MockTaskRepository();
      cubit = TaskListCubit(taskRepository: mockTaskRepository);
    });

    test('should have correct initial state', () {
      const expectedState = TaskListState(
        behavior: TaskListBehavior.initial,
        tasks: [],
        taskStatus: TaskStatus.toDo,
        currentPage: 0,
      );

      expect(TaskListCubit(taskRepository: mockTaskRepository).state, expectedState);
    });

    group('Task fetching', () {
      blocTest<TaskListCubit, TaskListState>('when fetch first page should emit with correct information',
        build: () => cubit,
        setUp: () {
          when(() => mockTaskRepository.getTasks(page: 0)).thenAnswer((answer) async => fp.right(pageMock));
        },
        act: (cubit) => cubit.updateStatus(TaskStatus.toDo),
        expect: () =>
        [
          const TaskListState(behavior: TaskListBehavior.firstFetching),
          TaskListState(
            behavior: TaskListBehavior.displayed,
            tasks: taskDisplayedMock,
            taskStatus: TaskStatus.toDo,
            currentPage: 0,
          ),
        ],
        verify: (cubit) {
          verify(() => mockTaskRepository.getTasks(page: 0));
          verifyNoMoreInteractions(mockTaskRepository);
        },
      );

      blocTest<TaskListCubit, TaskListState>('when fetch last page should emit with correct information',
        build: () => cubit,
        setUp: () {
          when(() => mockTaskRepository.getTasks(page: 1)).thenAnswer((answer) async => fp.right(pageMock2));
        },
        act: (cubit) => cubit.fetchTasks(1, TaskStatus.toDo),
        expect: () =>
        [
          TaskListState(
            behavior: TaskListBehavior.displayed,
            tasks: taskDisplayedMock2,
            taskStatus: TaskStatus.toDo,
            currentPage: 1,
            isEnded: true,
          ),
        ],
        verify: (cubit) {
          verify(() => mockTaskRepository.getTasks(page: 1));
          verifyNoMoreInteractions(mockTaskRepository);
        },
      );

      blocTest<TaskListCubit, TaskListState>('when fetch failed should emit with correct information',
        build: () => cubit,
        setUp: () {
          when(() => mockTaskRepository.getTasks(page: 0)).thenAnswer((answer) async => fp.left(const ApiFailure(message: 'Test Error')));
        },
        act: (cubit) => cubit.fetchTasks(0, TaskStatus.toDo),
        expect: () =>
        [
          const TaskListState(
            behavior: TaskListBehavior.failed,
            tasks: [],
            taskStatus: TaskStatus.toDo,
            currentPage: 0,
            isEnded: false,
          ),
        ],
        verify: (cubit) {
          verify(() => mockTaskRepository.getTasks(page: 0));
          verifyNoMoreInteractions(mockTaskRepository);
        },
      );
    });

    group('Task deleting', () {
      blocTest<TaskListCubit, TaskListState>('when delete task should remove correctly',
        build: () => cubit,
        setUp: () {
          cubit.emit(TaskListState(
            behavior: TaskListBehavior.displayed,
            tasks: taskDisplayedMock,
            taskStatus: TaskStatus.toDo,
            currentPage: 1,
            isEnded: false,
          ));
        },
        act: (cubit) => cubit.deleteTask('ID-1'),
        expect: () =>
        [
          TaskListState(
            behavior: TaskListBehavior.displayed,
            tasks: taskDisplayedDeleteMock,
            taskStatus: TaskStatus.toDo,
            currentPage: 1,
            isEnded: false,
          ),
        ],
        verify: (cubit) {
          verifyNoMoreInteractions(mockTaskRepository);
        },
      );
    });
  });
}